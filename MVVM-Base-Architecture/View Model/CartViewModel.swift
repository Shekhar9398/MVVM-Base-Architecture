
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cart = CartModel(products: [])

    init() {
        cart.products = [
            ProductModel(id: "1", name: "Laptop", price: 1200.0),
            ProductModel(id: "2", name: "Phone", price: 800.0)
        ]
    }
}
