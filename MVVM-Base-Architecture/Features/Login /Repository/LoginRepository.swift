import Foundation

class LoginRepository {
    private let persistence = PersistenceManager.shared
    private let userCredentialsKey = "userCredentials"
    private let credentialsSavedKey = "credentialsSaved"

    func saveUserCredentials() {
        ///Mark: Check if credentials have already been saved
        guard !UserDefaults.standard.bool(forKey: credentialsSavedKey) else {
            return
        }

        let credentials: [String: String] = [
            "Shekhar": "Shekhar@123",
            "Malcolm": "Malcolm@123",
            "Binnu": "Binnu@123"
        ]

        persistence.save(object: credentials, key: userCredentialsKey)

        /// Mark:-  credentials as saved to avoid future saves
        UserDefaults.standard.set(true, forKey: credentialsSavedKey)
    }

    func retrieveUserCredentials() -> [String: String]? {
        return persistence.retrieve(key: userCredentialsKey, type: [String: String].self)
    }
}
