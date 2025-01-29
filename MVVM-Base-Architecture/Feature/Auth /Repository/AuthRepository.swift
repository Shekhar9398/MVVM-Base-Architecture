
import Foundation

class AuthRepository {
    private let networkManager = NetworkManager.shared
    
    func fetchAuthData(completion: @escaping(Result<AuthModel, Error>) -> Void) {
        
        let endpoint: AuthEndpoint = .login(username: "emilys", password: "emilyspass")
        
        networkManager.requestWithToken(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let auth = try JSONDecoder().decode(AuthModel.self, from: data)
                    completion(.success(auth))
                } catch {
                    completion(.failure(error))
                }
               
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
