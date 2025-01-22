
import SwiftUI

class ProductsViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var errorMessage: String? = nil

    func fetchProducts() {
        let url = "https://api.example.com/products" // Replace with your endpoint

        NetworkManager.shared.fetchData(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let decodedProducts = try JSONDecoder().decode([ProductModel].self, from: data)
                        self?.products = decodedProducts
                    } catch {
                        self?.errorMessage = "Failed to decode data."
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
