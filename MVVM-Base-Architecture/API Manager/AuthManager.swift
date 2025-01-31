import Foundation

class AuthManager {
    static let shared = AuthManager()
    private init() {}

    func fetchToken(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let loginEndpoint = TokenEndpoint.login(username: username, password: password)

        let parameters = loginEndpoint.body.flatMap {
            try? JSONSerialization.jsonObject(with: $0, options: []) as? [String: Any]
        }

        NetworkManager.shared.request(
            baseURL: "https://www.dummyjson.com",
            endpoint: loginEndpoint.path,
            method: loginEndpoint.method,
            parameters: parameters,
            headers: loginEndpoint.headers,
            requiresAuth: false,
            responseType: TokenResponse.self
        ) { result in
            switch result {
            case .success(let tokenResponse):
                TokenStorage.shared.saveTokens(accessToken: tokenResponse.accessToken, refreshToken: tokenResponse.refreshToken)
                print("Token Saved: \(tokenResponse.accessToken)")
                completion(.success(tokenResponse.accessToken))
            case .failure(let error):
                print("Token Fetch Failed: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
