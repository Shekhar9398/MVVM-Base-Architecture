
import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()

    var body: some View {
        VStack {
            List(viewModel.cart.products) { product in
                ProductCellView(product: product)
            }
            Text("Total: $\(viewModel.cart.totalPrice, specifier: "%.2f")")
                .font(.headline)
        }
        .navigationTitle("Cart")
    }
}
