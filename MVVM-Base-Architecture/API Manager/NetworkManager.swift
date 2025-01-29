import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    let baseURL = URL(string: "https://dummyjson.com")!

    ///Mark: - Token Request
    func fetchAuthToken(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = AuthEndpoint.login(username: username, password: password)
        var request = endpoint.createRequest(baseURL: baseURL)

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
                let response = try JSONDecoder().decode(AuthModel.self, from: data)
                completion(.success(response.token))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    /// Mark: - Request with Token
        func requestWithToken(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let token = TokenManager.shared.getToken() else {
            completion(.failure(NetworkError.noAccessToken))
            return
        }

        var request = endpoint.createRequest(baseURL: baseURL)
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
