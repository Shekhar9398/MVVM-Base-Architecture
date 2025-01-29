import Foundation

class LoginRepository {
    private let persistence = PersistenceManager.shared
    private let userCredentialsKey = "userCredentials"
    
    func saveUserCredentials() {
        let credentials: [String: String] = [
            "Shekhar": "Shekhar@123",
            "Malcolm": "Malcolm@123",
            "Binnu": "Binnu@123"
        ]
        
        persistence.save(object: credentials, key: userCredentialsKey)
    }
    
    func retrieveUserCredentials() -> [String: String]? {
        return persistence.retrieve(key: userCredentialsKey, type: [String: String].self)
    }
}
