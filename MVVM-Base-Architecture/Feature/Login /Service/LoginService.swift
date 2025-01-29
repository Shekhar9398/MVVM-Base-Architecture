
import Foundation

class LoginService{
    private let repository = LoginRepository()
    
    func getUserNamePassword() -> [String: String]{
       let creds = repository.retrieveUserCredentials()
        return creds!
    }
}
