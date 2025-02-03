import Foundation

/// MARK: - Token Storage
class TokenStorage {
    private let tokenKey = "authToken"
    private let refreshTokenKey = "refreshToken"

    static let shared = TokenStorage()
    private init() {}

    func getAccessToken() -> String? {
        let token = UserDefaults.standard.string(forKey: tokenKey)
        print("[TokenStorage] Retrieved access token: \(token ?? "nil")")
        return token
    }

    func getRefreshToken() -> String? {
        let token = UserDefaults.standard.string(forKey: refreshTokenKey)
        print("[TokenStorage] Retrieved refresh token: \(token ?? "nil")")
        return token
    }

    func saveTokens(accessToken: String, refreshToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: tokenKey)
        UserDefaults.standard.setValue(refreshToken, forKey: refreshTokenKey)
        print("[TokenStorage] Saved access token: \(accessToken)")
        print("[TokenStorage] Saved refresh token: \(refreshToken)")
    }

    func clearTokens() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
        print("[TokenStorage] Cleared all tokens")
    }
}
