import Foundation

class CastsService {
    private let repository = CastsRepository()
    
    func getCastsData(completion: @escaping (Result<CastsModel, Error>) -> Void) {
        repository.fetchCastsData { completion($0) }
    }
}
