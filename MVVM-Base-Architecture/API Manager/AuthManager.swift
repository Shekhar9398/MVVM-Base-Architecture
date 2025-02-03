import Foundation

/// MARK: - Authentication Manager
class AuthManager {
    static let shared = AuthManager()
    private let baseUrl = "https://api.vainu.io/api/v2/token_authentication"
    
    private init() {}

    ///Mark:-  Fetch token using username and password
    func fetchToken(username: String, password: String, completion: @escaping (Result<TokenModel, Error>) -> Void) {
        let loginEndpoint = TokenEndpoint.login(username: username, password: password)

        NetworkManager.shared.request(
            baseURL: baseUrl,
            endpoint: loginEndpoint.path,
            method: loginEndpoint.method,
            parameters: nil,
            headers: loginEndpoint.headers,
            responseType: TokenModel.self,
            completion: completion
        )
    }
}
