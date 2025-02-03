import Foundation

/// MARK: - Request Interceptor Protocol
protocol RequestInterceptor {
    func intercept(request: URLRequest) -> URLRequest
}


/// MARK: - NetworkManager
class NetworkManager {
    static let shared = NetworkManager()
    let session: URLSession
    var interceptors: [RequestInterceptor] = []

    private init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
        print("[NetworkManager] Initialized with default session configuration.")
    }

    func addInterceptor(_ interceptor: RequestInterceptor) {
        interceptors.append(interceptor)
        print("[NetworkManager] Interceptor added: \(interceptor)")
    }

    func request<T: Codable>(
        baseURL: String,
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint) else {
            print("[NetworkManager] Invalid URL: \(baseURL + endpoint)")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        print("[NetworkManager] Request prepared: \(request)")

        // Add Authorization header with existing access token
        if let accessToken = TokenStorage.shared.getAccessToken() {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                print("[NetworkManager] Request body: \(parameters)")
            } catch {
                print("[NetworkManager] JSON serialization error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
        }

        for interceptor in interceptors {
            request = interceptor.intercept(request: request)
            print("[NetworkManager] Request after interceptor: \(request)")
        }

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[NetworkManager] Request failed with error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("[NetworkManager] No valid HTTP response.")
                completion(.failure(NetworkError.noData))
                return
            }

            print("[NetworkManager] Response status code: \(httpResponse.statusCode)")

            guard let data = data else {
                print("[NetworkManager] No data received.")
                completion(.failure(NetworkError.noData))
                return
            }

            // Handle the 401 error: Attempt token refresh
            if httpResponse.statusCode == 401 {
                print("[NetworkManager] 401 error: Access token expired. Attempting to refresh.")
                TokenManager.shared.refreshToken { result in
                    switch result {
                    case .success:
                        print("[NetworkManager] Successfully refreshed access token.")
                        // Retry the original request with the new token
                        self.retryRequest(baseURL: baseURL, endpoint: endpoint, method: method, parameters: parameters, headers: headers, responseType: responseType, completion: completion)
                    case .failure(let error):
                        print("[NetworkManager] Failed to refresh access token: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
                return
            }

            // Print raw response data for debugging
            if let rawString = String(data: data, encoding: .utf8) {
                print("[NetworkManager] Raw response data: \(rawString)")
            } else {
                print("[NetworkManager] Response data is not valid UTF-8.")
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                print("[NetworkManager] Response decoded successfully: \(decodedData)")
                DispatchQueue.main.async { completion(.success(decodedData)) }
            } catch {
                print("[NetworkManager] Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(.failure(NetworkError.decodingError)) }
            }
        }.resume()
    }

    // Retry the original request with a new access token
    private func retryRequest<T: Codable>(
        baseURL: String,
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        self.request(baseURL: baseURL, endpoint: endpoint, method: method, parameters: parameters, headers: headers, responseType: responseType, completion: completion)
    }
}
