import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var token: String?
    @Published var state: ViewState<AuthModel> = .idle

    private let authRepository = AuthRepository()

    ///Mark:- Fetch token for authentication
    func fetchToken(username: String, password: String) {
        state = .loading

        let endpoint = AuthEndpoint.login(username: username, password: password)
        
        NetworkManager.shared.request(
            endpoint: endpoint,
            responseType: AuthModel.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authModel):
                    self?.token = authModel.token
                    TokenManager.shared.setToken(authModel.token)
                    self?.fetchAuthData()
                case .failure(let error):
                    self?.state = .error(errorMessage: error.localizedDescription)
                }
            }
        }
    }

    ///Mark:-  Fetch authenticated user data
    func fetchAuthData() {
        state = .loading

        authRepository.fetchAuthData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let auth):
                    self?.state = .data(model: auth)
                case .failure(let error):
                    self?.state = .error(errorMessage: error.localizedDescription)
                }
            }
        }
    }
}
