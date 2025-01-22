

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            List(viewModel.products) { product in
                ProductCellView(product: product)
            }
            .navigationTitle("Products")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

