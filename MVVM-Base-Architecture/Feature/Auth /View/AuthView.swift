import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle:
                Text("Starting authentication...")
                    .foregroundColor(.gray)

            case .loading:
                ProgressView("Please wait...") // Shows a loading indicator

            case .data(let authModel):
                VStack {
                    Text("Authentication Successful!")
                        .font(.headline)
                        .foregroundColor(.green)

                    Text("Token: \(authModel.token)")
                        .font(.subheadline)
                        .padding()
                        .background(Color.mint.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

            case .error(let errorMessage):
                VStack {
                    Text("Authentication Failed")
                        .foregroundColor(.red)
                        .bold()

                    Text(errorMessage)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchToken(username: "emilys", password: "emilyspass")
        }
    }
}

#Preview {
    AuthView()
}
