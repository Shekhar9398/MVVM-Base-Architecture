import Foundation

///Mark:- API Manager Class
class NetworkHelper {
    static func sendRequest<T: Codable>(
        url: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        requiresAuth: Bool = false,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let requestURL = URL(string: url) else {
            print("Invalid URL: \(url)")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var allHeaders = headers ?? [:]
        if requiresAuth, let token = TokenStorage.shared.getAccessToken() {
            allHeaders["Authorization"] = "Bearer \(token)"
        }

        for (key, value) in allHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if method != .get, let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                print("Failed to encode request body: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response from server")
                DispatchQueue.main.async { completion(.failure(NetworkError.noData)) }
                return
            }

            if httpResponse.statusCode == 401, requiresAuth {
                print("Token expired, attempting to refresh...")
                TokenManager.shared.refreshToken { refreshResult in
                    switch refreshResult {
                    case .success():
                        print("Token refreshed successfully, retrying request...")
                        sendRequest(url: url, method: method, parameters: parameters, headers: headers, requiresAuth: requiresAuth, responseType: responseType, completion: completion)
                    case .failure(let refreshError):
                        print("Token refresh failed: \(refreshError.localizedDescription)")
                        DispatchQueue.main.async { completion(.failure(refreshError)) }
                    }
                }
                return
            }

            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async { completion(.failure(NetworkError.noData)) }
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decodedResponse)) }
            } catch {
                print("JSON Decoding Error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(.failure(NetworkError.decodingError)) }
            }
        }.resume()
    }
}
