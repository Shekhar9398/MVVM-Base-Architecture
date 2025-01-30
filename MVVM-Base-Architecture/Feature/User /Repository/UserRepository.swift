import Foundation

class UserRepository {
    private let networkManager = NetworkManager.shared

    func fetchUserData(completion: @escaping (Result<UserModel, Error>) -> Void) {
        let endpoint: UserEndpoint = .getUserData
        
        networkManager.request(
            endpoint: endpoint,
            responseType: UserModel.self
        ) { result in
            completion(result)
        }
    }
}
