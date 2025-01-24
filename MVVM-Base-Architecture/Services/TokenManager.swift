
import SwiftUI

class TokenManager {
    static let shared = TokenManager()
    private init() {}

    private let userDefaults = UserDefaults.standard

    func getToken() -> String? {
        return userDefaults.string(forKey: "token")
    }

    func saveToken(_ token: String) {
        userDefaults.setValue(token, forKey: "token")
    }

    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        // Simulate refresh token API call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            // For simplicity, assume token refresh is successful
            self.saveToken("newAccessToken")
            completion(.success(()))
        }
    }
}
