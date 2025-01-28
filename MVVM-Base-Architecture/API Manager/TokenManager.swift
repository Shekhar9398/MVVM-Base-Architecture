import Foundation

class TokenManager {
    static let shared = TokenManager()
    private init() {}

    private let tokenKey = "authToken"

    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }

    func setToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: tokenKey)
    }

    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let newToken = "new_refreshed_token"
            self.setToken(newToken)
            completion(.success(()))
        }
    }

    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
