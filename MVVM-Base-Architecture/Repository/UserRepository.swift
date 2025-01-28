import Foundation

class UserRepository {
    private let networkManager = NetworkManager.shared

    func fetchUserData(completion: @escaping (Result<UserModel, Error>) -> Void) {
        networkManager.requestWithToken(endpoint: "/auth/me") { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
