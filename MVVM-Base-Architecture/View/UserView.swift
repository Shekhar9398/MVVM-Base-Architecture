
import SwiftUI

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("Idle State")
            case .loading:
                ProgressView()
            case .data:
                if let user = viewModel.user {
                    Text("Hello, \(user.name)")
                }
            case .error:
                Text("Something went wrong.")
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}
