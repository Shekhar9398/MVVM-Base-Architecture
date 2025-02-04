import Foundation

class UserService {
    private let repository = UserRepository()

    func getUsers(completion: @escaping (Result<UserListResponse, Error>) -> Void) {
        repository.fetchUserList { result in
            switch result {
            case .success(let userList):
                completion(.success(userList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
