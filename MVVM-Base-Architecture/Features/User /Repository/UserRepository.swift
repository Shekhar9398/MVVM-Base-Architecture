import Foundation

class UserRepository {
    private let networkManager = NetworkManager.shared
    private let baseUrl = "https://www.dummyjson.com"

    func fetchUserData(completion: @escaping (Result<UserModel, Error>) -> Void) {
        let endpoint = UserEndpoint.getUserData
        
        networkManager.request(
            baseURL: baseUrl,
            endpoint: endpoint.path,
            responseType: UserModel.self
        ) { result in
            completion(result)
        }
    }
}
