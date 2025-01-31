import Foundation

class TokenManager {
    static let shared = TokenManager()
    private init() {}

    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let refreshToken = TokenStorage.shared.getRefreshToken() else {
            print("No refresh token available, user might need to re-login.")
            TokenStorage.shared.clearTokens()
            completion(.failure(NetworkError.noData))
            return
        }

        let refreshEndpoint = TokenEndpoint.refresh(refreshToken: refreshToken)

        let parameters = refreshEndpoint.body.flatMap {
            try? JSONSerialization.jsonObject(with: $0, options: []) as? [String: Any]
        }

        NetworkManager.shared.request(
            baseURL: "https://www.dummyjson.com",
            endpoint: refreshEndpoint.path,
            method: refreshEndpoint.method,
            parameters: parameters,
            headers: refreshEndpoint.headers,
            requiresAuth: false,
            responseType: TokenModel.self
        ) { result in
            switch result {
            case .success(let tokenResponse):
                print("Token Refreshed Successfully: \(tokenResponse.accessToken)")
                TokenStorage.shared.setAccessToken(tokenResponse.accessToken)
                TokenStorage.shared.setRefreshToken(tokenResponse.refreshToken)
                completion(.success(()))
            case .failure(let error):
                print("Token Refresh Failed: \(error.localizedDescription)")
                TokenStorage.shared.clearTokens()
                completion(.failure(error))
            }
        }
    }
}
