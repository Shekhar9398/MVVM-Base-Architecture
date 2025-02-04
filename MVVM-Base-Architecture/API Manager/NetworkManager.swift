import Foundation

// MARK: - Network Manager
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    // MARK: - General API Request
    func request<T: Codable>(
        url: String,
        method: String = "GET",
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let requestUrl = URL(string: url) else {
            print("[NetworkManager] Invalid URL: \(url)")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = method
        request = AccessTokenInterceptor.addAuthorizationHeader(to: request)

        // MARK: - Add Custom Headers
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        // MARK: - Encode Parameters
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            print("[NetworkManager] Request Body: \(parameters)")
        }

        print("[NetworkManager] Sending \(method) Request to: \(url)")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[NetworkManager] Request Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                print("[NetworkManager] No Response Data Received.")
                completion(.failure(NetworkError.noData))
                return
            }

            print("[NetworkManager] Response Status Code: \(httpResponse.statusCode)")

            // MARK: - Handle Unauthorized (401)
//            if httpResponse.statusCode == 401 {
//                print("[NetworkManager] Unauthorized (401) - Attempting Token Refresh")
//                AccessTokenInterceptor.handleTokenExpiration { success in
//                    if success {
//                        // Retry Request With New Token
//                        print("[NetworkManager] Retrying Request with New Access Token")
//                        self.request(url: url, method: method, parameters: parameters, headers: headers, responseType: responseType, completion: completion)
//                    } else {
//                        print("[NetworkManager] Token Refresh Failed, User Must Login Again")
//                        completion(.failure(NetworkError.tokenRefreshFailed))
//                    }
//                }
//                return
//            }

            // MARK: - Parse Response Data
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                print("[NetworkManager] Response Decoded Successfully: \(decodedData)")
                completion(.success(decodedData))
            } catch {
                print("[NetworkManager] Decoding Error: \(error.localizedDescription)")
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}

// MARK: - Token Response Model
struct TokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

// MARK: - Network Error Enum
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case tokenRefreshFailed
    case serverError
}

///Mark: Http Methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
