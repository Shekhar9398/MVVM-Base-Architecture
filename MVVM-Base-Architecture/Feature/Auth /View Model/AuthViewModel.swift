
import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var auth: AuthModel?
    @Published var token: String?
    @Published var state: ViewState = .idle
    @Published var errorMessage: String?
    
    private let authService = AuthService()
    
///Mark :- Fetch token for auth
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
                    self?.fetchAuthData()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.state = .error
                }
            }
        }
    }
    
    ///Mark:-  Fetch Data for auth
     func fetchAuthData() {
        state = .loading

        authService.getAuth { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let auth):
                    self.auth = auth
                    self.state = .data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.state = .error
                }
            }
        }
    }
}
