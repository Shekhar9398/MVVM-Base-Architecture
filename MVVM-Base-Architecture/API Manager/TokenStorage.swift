import Foundation

// MARK: - Token Storage
class TokenStorage {
    static let shared = TokenStorage()
    
    private init() {}

    // MARK: - Access Token Methods
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }

    func setAccessToken(_ token: String) {
        print("[TokenStorage] Saving Access Token")
        UserDefaults.standard.set(token, forKey: "accessToken")
    }

    // MARK: - Refresh Token Methods
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }

    func setRefreshToken(_ token: String) {
        print("[TokenStorage] Saving Refresh Token")
        UserDefaults.standard.set(token, forKey: "refreshToken")
    }
}
