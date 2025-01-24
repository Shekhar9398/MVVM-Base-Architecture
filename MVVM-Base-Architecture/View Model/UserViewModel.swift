
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var state: ViewState = .idle
    @Published var user: UserModel?

    private let repository = UserRepository()

    func fetchUser() {
        state = .loading

        repository.fetchUserData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.state = .data
                case .failure:
                    self?.state = .error
                }
            }
        }
    }
}
