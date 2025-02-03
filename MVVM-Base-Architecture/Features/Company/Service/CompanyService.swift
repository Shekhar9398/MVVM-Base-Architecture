
import SwiftUI

class CompanyService {
    private let repository = CompanyRepository()

    func getUser(completion: @escaping (Result<UserModel, Error>) -> Void) {
        repository.fetchUserData { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
