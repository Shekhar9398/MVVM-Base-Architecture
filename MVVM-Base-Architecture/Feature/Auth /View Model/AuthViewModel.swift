import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var auth: AuthModel?
    @Published var token: String?
    @Published var state: ViewState = .idle
    @Published var errorMessage: String?

    private let authRepository = AuthRepository()

    /// Fetch token for authentication
    func fetchToken(username: String, password: String) {
        state = .loading
        errorMessage = nil

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
                    self?.state = .data
                    self?.fetchAuthData() // Fetch user data after getting the token
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.state = .error
                }
            }
        }
    }

    /// Fetch authenticated user data
    func fetchAuthData() {
        state = .loading

        authRepository.fetchAuthData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let auth):
                    self?.auth = auth
                    self?.state = .data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.state = .error
                }
            }
        }
    }
}
