import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var state: ViewState<UserListResponse> = .idle
    private let userService = UserService()
    private let authManager = AuthManager.shared

    func login(email: String, password: String) {
        state = .loading
        
        authManager.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let accessToken):
                    print("accessToken successful: \(accessToken)")
                    self.fetchUserData()
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                    self.state = .error(errorMessage: error.localizedDescription)
                }
            }
        }
    }

    func fetchUserData() {
        state = .loading
        
        userService.getUsers { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let users):
                    self.state = .data(model: users)
                case .failure(let error):
                    self.state = .error(errorMessage: error.localizedDescription)
                }
            }
        }
    }
}
