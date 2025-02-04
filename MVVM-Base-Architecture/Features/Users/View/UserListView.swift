
import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserViewModel()
    private let userEmail =  "eve.holt@reqres.in"
    private let userPassword = "cityslicka"
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("Idle")
            case .loading:
                Text("Please Wait..")
            case .data(let model):
                VStack{
                    Text("\(model.page)")
                }
            case .error(let errorMessage):
                Text("\(errorMessage)")
            }
        }
        .onAppear{
            viewModel.login(email: userEmail, password: userPassword)
        }
    }
}

#Preview {
    UserListView()
}
