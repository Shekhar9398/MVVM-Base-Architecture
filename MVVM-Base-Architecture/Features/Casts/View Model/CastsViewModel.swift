import Foundation

@MainActor
class CastsViewModel: ObservableObject {
    
    @Published var state: ViewState<CastsModel> = .idle
    private let castsService = CastsService()

    func fetchCasts() {
        self.state = .loading
        
        castsService.getCastsData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
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
