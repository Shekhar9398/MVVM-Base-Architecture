import SwiftUI

@MainActor
class CompanyViewModel: ObservableObject {
    @Published var token: String?
    @Published var state: ViewState<CompanyModel> = .idle

    private let companyRepository = CompanyRepository()

    func login(username: String, password: String) {
        state = .loading

        AuthManager.shared.fetchToken(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenModel):
                    self?.token = tokenModel.accessToken
                    self?.fetchUserData()
                case .failure(let error):
                    self?.state = .error(errorMessage: "Login Failed: \(error.localizedDescription)")
                }
            }
        }
    }

    private func fetchUserData() {
        guard let token = TokenStorage.shared.getAccessToken() else {
            DispatchQueue.main.async {
                self.state = .error(errorMessage: "Invalid token")
            }
            return
        }

        state = .loading
        companyRepository.fetchUserData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.state = .data(model: user)
                case .failure(let error):
                    self?.state = .error(errorMessage: "Fetching Error - \(error.localizedDescription)")
                }
            }
        }
    }
}
