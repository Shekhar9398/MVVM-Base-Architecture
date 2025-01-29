
import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("staring")
            case .loading:
                Text("Please Wait")
            case .data:
                Text("Token \(viewModel.auth?.token ?? " No Token")")
                    .foregroundStyle(Color.mint)
                    .bold()
                    .padding()
            case .error:
                Text("error while fetching token")
                 
            }
        }
        .onAppear{
            viewModel.fetchToken(username: "emilys", password: "emilyspass")
        }
    }
}

#Preview {
    AuthView()
}
