import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var token: String?
    @Published var state: ViewState = .idle
    @Published var errorMessage: String?

    private let userService = UserService()

    // Fetch token using username and password
    func fetchToken(username: String, password: String) {
        state = .loading
        errorMessage = nil

        NetworkManager.shared.fetchAuthToken(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self?.token = token
                    TokenManager.shared.setToken(token)
                    self?.state = .data
                    self?.fetchUserData()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.state = .error
                }
            }
        }
    }

    // Fetch user data using the token
    private func fetchUserData() {
        state = .loading

        userService.getUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.state = .data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.state = .error
                }
            }
        }
    }
}

