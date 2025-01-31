import Foundation

class TokenStorage {
    private let tokenKey = "authToken"
    private let refreshTokenKey = "refreshToken"

    static let shared = TokenStorage()
    private init() {}

    // MARK: - Retrieve Tokens
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }

    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: refreshTokenKey)
    }

    // MARK: - Save & Update Tokens
    func saveTokens(accessToken: String, refreshToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: tokenKey)
        UserDefaults.standard.setValue(refreshToken, forKey: refreshTokenKey)
        print("Tokens saved successfully")
    }

    func setAccessToken(_ accessToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: tokenKey)
        print("Access token updated: \(accessToken)")
    }

    func setRefreshToken(_ refreshToken: String) {
        UserDefaults.standard.setValue(refreshToken, forKey: refreshTokenKey)
        print("Refresh token updated: \(refreshToken)")
    }

    // MARK: - Clear Tokens
    func clearTokens() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
        print("Tokens cleared")
    }
}
