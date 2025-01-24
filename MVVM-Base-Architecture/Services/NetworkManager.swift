
import SwiftUI

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    let baseURL = URL(string: "https://api.example.com")!

    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let token = TokenManager.shared.getToken() else {
            refreshAndRetry(endpoint: endpoint, completion: completion)
            return
        }

        var request = endpoint.createRequest(baseURL: baseURL)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            if httpResponse.statusCode == 401 {
                self.refreshAndRetry(endpoint: endpoint, completion: completion)
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }

    private func refreshAndRetry(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        TokenManager.shared.refreshToken { [weak self] result in
            switch result {
            case .success:
                self?.request(endpoint: endpoint, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
