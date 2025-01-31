import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var token: String?
    @Published var state: ViewState<UserModel> = .idle

    private let userRepository = UserRepository()

    func login(username: String, password: String) {
        state = .loading

        AuthManager.shared.fetchToken(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let accessToken):
                self?.token = accessToken
                self?.fetchUserData() 
            case .failure(let error):
                self?.state = .error(errorMessage: "Login Failed: \(error.localizedDescription)")
            }
        }
    }

    private func fetchUserData() {
        guard let token = TokenStorage.shared.getAccessToken() else {
            state = .error(errorMessage: "Invalid token")
            return
        }

        state = .loading
        userRepository.fetchUserData { [weak self] result in
            switch result {
            case .success(let user):
                self?.state = .data(model: user)
            case .failure(let error):
                self?.state = .error(errorMessage: "Fetching Error - \(error.localizedDescription)")
            }
        }
    }
}
