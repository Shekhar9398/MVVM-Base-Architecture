import Foundation

class CastsViewModel: ObservableObject {
    
    @Published var state: ViewState<CastsModel> = .idle
    private let castsService = CastsService()
    private let repository = CastsRepository()

    func fetchCasts() {
        self.state = .loading
        
        repository.fetchCastsData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let casts):
                    self.state = .data(model: casts)
                case .failure(let error):
                    self.state = .error(errorMessage: error.localizedDescription)
                }
            }
        }
    }
}
