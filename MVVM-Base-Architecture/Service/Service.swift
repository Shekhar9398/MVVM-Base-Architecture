
import SwiftUI

class UserService {
    private let repository = UserRepository()

    func getUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
        repository.fetchUserData { result in
            switch result {
            case .success(let user):
                // Perform any additional business logic or transformation here
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
