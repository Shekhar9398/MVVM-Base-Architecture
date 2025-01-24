
import SwiftUI

class UserRepository {
    private let persistenceKey = "UserModelKey"

    func fetchUserData(completion: @escaping (Result<UserModel, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: UserEndpoint.getUserData) { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    PersistenceManager.shared.save(object: user, key: self.persistenceKey)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure:
                if let cachedUser = PersistenceManager.shared.retrieve(key: self.persistenceKey, type: UserModel.self) {
                    completion(.success(cachedUser))
                } else {
                    completion(.failure(NetworkError.noData))
                }
            }
        }
    }
}
