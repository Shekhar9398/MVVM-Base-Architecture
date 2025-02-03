import Foundation

class CastsService {
    private let repository = CastsRepository()
    
    func getCastsData(completion: @escaping (Result<CastsModel, Error>) -> Void) {
        repository.fetchCastsData { result in
            completion(result)
        }
    }
}
