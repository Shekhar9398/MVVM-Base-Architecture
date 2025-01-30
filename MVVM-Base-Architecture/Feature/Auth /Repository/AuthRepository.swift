import Foundation

class AuthRepository {
    private let networkManager = NetworkManager.shared

    func fetchAuthData(completion: @escaping (Result<AuthModel, Error>) -> Void) {
        let endpoint: AuthEndpoint = .login(username: "emilys", password: "emilyspass")

        networkManager.request(
            endpoint: endpoint,
            responseType: AuthModel.self
        ) { result in
            completion(result)
        }
    }
}
