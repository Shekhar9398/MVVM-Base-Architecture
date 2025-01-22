
import SwiftUI

struct ProductCellView: View {
    let product: ProductModel

    var body: some View {
        HStack {
            Text(product.name)
            Spacer()
            Text(CommonMethods.formatCurrency(product.price))
        }
        .padding()
    }
}
