import Foundation

/// MARK: - Token Manager
class TokenManager {
    static let shared = TokenManager()
    private let baseUrl = "https://api.vainu.io/api/v2/token_authentication"
    private init() {}

    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let refreshToken = TokenStorage.shared.getRefreshToken() else {
            print("No refresh token available. Clearing stored tokens.")
            TokenStorage.shared.clearTokens()
            completion(.failure(NetworkError.noData))
            return
        }

        let refreshEndpoint = TokenEndpoint.refresh(refreshToken: refreshToken)
        let url = baseUrl + refreshEndpoint.path
        print("Refreshing token using endpoint: \(url)")

        NetworkManager.shared.request(
            baseURL: baseUrl,
            endpoint: refreshEndpoint.path,
            method: refreshEndpoint.method,
            parameters: nil,
            headers: refreshEndpoint.headers,
            responseType: TokenModel.self
        ) { result in
            switch result {
            case .success(let tokenResponse):
                TokenStorage.shared.saveTokens(
                    accessToken: tokenResponse.accessToken,
                    refreshToken: tokenResponse.refreshToken
                )
                print("Tokens saved successfully.")
                completion(.success(()))
            case .failure(let error):
                TokenStorage.shared.clearTokens()
                print("Token refresh failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
