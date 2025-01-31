import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: [String] = []
    @Published var password: [String] = []
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    private let service = LoginService()

    ///Mark:-  Setup credentials by fetching and saving once
    func setupUserCredentials() {
        service.saveUserCredsOnce()
        let (usernames, passwords) = service.getUserNamePassword()
        
        self.username = usernames
        self.password = passwords
    }

    ///Mark:-  Check login credentials
    func checkLoginCredentials(inputUsername: String, inputPassword: String) {
        ///Mark:-  Check if the entered username and password are in the stored credentials
        if let index = username.firstIndex(of: inputUsername), password.indices.contains(index), password[index] == inputPassword {
            isLoggedIn = true
            errorMessage = nil
        } else {
            isLoggedIn = false
            errorMessage = "Invalid username or password"
        }
    }
}
