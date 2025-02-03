import Foundation

class CastsRepository {
    private let networkManager = NetworkManager.shared
    private let baseUrl = "https://klipy-gifs-stickers-clips.p.rapidapi.com"

    init() {
        let authInterceptor = AuthenticationInterceptor()
        networkManager.addInterceptor(authInterceptor)
    }

    func fetchCastsData(completion: @escaping (Result<CastsModel, Error>) -> Void) {
        let endpoint = CastsEndpoint.getCastsData
        var request = URLRequest(url: URL(string: baseUrl + endpoint.path)!)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers

        networkManager.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode == 401 {
                if let interceptor = self.networkManager.interceptors.first(where: { $0 is AuthenticationInterceptor }) as? AuthenticationInterceptor {
                    interceptor.handleUnauthorizedError(request: request) { result in
                        switch result {
                        case .success:
                            // Retry the original request after successful token refresh
                            self.fetchCastsData(completion: completion)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
                return
            }

            if let data = data {
                do {
                    let castsData = try JSONDecoder().decode(CastsModel.self, from: data)
                    completion(.success(castsData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkError.noData))
            }
        }.resume()
    }
}
