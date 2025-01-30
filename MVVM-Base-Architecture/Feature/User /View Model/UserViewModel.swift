import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var token: String?
    @Published var state: ViewState = .idle
    @Published var errorMessage: String?

    private let authRepository = AuthRepository()
    private let userRepository = UserRepository()

    ///Mark:- Fetch token using username and password
    func fetchToken(username: String, password: String) {
        state = .loading
        errorMessage = nil

        authRepository.fetchAuthData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authModel):
                    self?.token = authModel.token
                    TokenManager.shared.setToken(authModel.token)
                    self?.state = .data
                    self?.fetchUserData()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.state = .error
                }
            }
        }
    }

    ///Mark:- Fetch user data using the token
    private func fetchUserData() {
        state = .loading

        userRepository.fetchUserData { [weak self] result in
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
