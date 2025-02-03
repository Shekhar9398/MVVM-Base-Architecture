import SwiftUI

struct CompanyView: View {
    @StateObject private var viewModel = CompanyViewModel()

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("start")
            case .loading:
                Text("please wait...")
            case .data(let model):
                VStack{
                    Text("\(model.companyName)")
                }
            case .error(let errorMessage):
                Text("Error :- \(errorMessage)")
            }
        }
        .onAppear {
            viewModel.login(username: "emilys", password: "emilyspass")
        }
        .navigationTitle("User Profile")
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)) 
    }
}
