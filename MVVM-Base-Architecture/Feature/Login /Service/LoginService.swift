import Foundation

class LoginService {
    private let repository = LoginRepository()
    
    func saveUserCredsOnce() {
        repository.saveUserCredentials()
    }
    
    ///Mark:-  Retrieve credentials and separate into username and password arrays
    func getUserNamePassword() -> (usernames: [String], passwords: [String]) {
        guard let creds = repository.retrieveUserCredentials() else {
            return (usernames: [], passwords: [])
        }
        
        ///Mark:-  Separate keys (usernames) and values (passwords)
        let usernames = Array(creds.keys)
        let passwords = Array(creds.values)
        
        return (usernames, passwords)
    }
}

