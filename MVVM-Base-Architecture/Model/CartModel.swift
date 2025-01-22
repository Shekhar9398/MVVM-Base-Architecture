
import SwiftUI

struct CartModel {
    var products: [ProductModel]
    var totalPrice: Double {
        products.reduce(0) { $0 + $1.price }
    }
}
