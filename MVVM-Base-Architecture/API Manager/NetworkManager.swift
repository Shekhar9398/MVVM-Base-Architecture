import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    let baseURL = URL(string: "https://dummyjson.com")!

    ///Mark:- Generic request method supporting all HTTP methods and body data
    func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        requiresAuth: Bool = false,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = endpoint.createRequest(baseURL: baseURL)

        ///Mark:-  Add authentication if required
        if requiresAuth, let token = TokenManager.shared.getToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

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
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
