
import Foundation

class AuthService {
    private let repository = AuthRepository()
    
    func getAuth(completion: @escaping(Result<AuthModel, Error>)-> Void) {
        repository.fetchAuthData { result in
            switch result {
            case .success(let auth):
                completion(.success(auth))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
