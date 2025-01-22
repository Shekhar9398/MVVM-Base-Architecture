

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Go to Products", destination: ProductsView())
                NavigationLink("Go to Cart", destination: CartView())
            }
            .navigationTitle("Home")
        }
    }
}
