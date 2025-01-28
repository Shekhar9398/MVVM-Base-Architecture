import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    let baseURL = URL(string: "https://dummyjson.com")!

    // Fetch the login token
    func fetchAuthToken(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/auth/login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "username": username,
            "password": password,
            "expiresInMins": 30
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(response.token))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Make a general API request with a token
    func requestWithToken(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let token = TokenManager.shared.getToken() else {
            completion(.failure(NetworkError.noAccessToken))
            return
        }

        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }.resume()
    }
}

