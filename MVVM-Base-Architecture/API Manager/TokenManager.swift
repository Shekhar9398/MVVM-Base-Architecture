import Foundation

class TokenManager {
    static let shared = TokenManager()
    private init() {}

    private var accessToken: String?

    /// Get stored token
    func getToken() -> String? {
        return accessToken
    }

    /// Set the token
    func setToken(_ token: String) {
        self.accessToken = token
    }

    /// Simulate token refresh
    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.accessToken = "new_refreshed_token"
            completion(.success(()))
        }
    }
}
