import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var token: String?
    @Published var state: ViewState<UserModel> = .idle

    private let authRepository = AuthRepository()
    private let userRepository = UserRepository()

    ///Mark:- Fetch token using username and password
    func fetchToken(username: String, password: String) {
        state = .loading

        authRepository.fetchAuthData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authModel):
                    self?.token = authModel.token
                    TokenManager.shared.setToken(authModel.token)
                    self?.fetchUserData()
                case .failure(let error):
                    self?.state = .error(errorMessage: error.localizedDescription)
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
                    self?.state = .data(model: user)
                case .failure(let error):
                    self?.state = .error(errorMessage: error.localizedDescription)
                }
            }
        }
    }
}
