import SwiftUI

struct LoginScreenView: View {
    @State private var userName = ""
    @State private var passWord = ""
    @State private var giveLoginAcess = false
    @State private var errorMessage = ""
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ///Mark:- Username and password input fields
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.title2)
                        .bold()
                    
                    TextField("Enter Username", text: $userName)
                        .font(.title2)
                        .bold()
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                    
                    Text("Password")
                        .font(.title2)
                        .bold()
                    
                    SecureField("Enter Password", text: $passWord)
                        .font(.title2)
                        .bold()
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                
                ///Mark:- Handle different states (loading, error, etc.)
                if !viewModel.isLoggedIn && viewModel.errorMessage != nil {
                    Text(viewModel.errorMessage ?? "")
                        .foregroundColor(.red)
                        .padding()
                }
                
                ///Mark:- Navigation to the next screen
                NavigationLink(destination: UserView(), isActive: $giveLoginAcess) {
                    EmptyView()
                }
                
                ///Mark:- Login Button
                Button(action: {
                    viewModel.checkLoginCredentials(inputUsername: userName, inputPassword: passWord)
                    
                    // If login is successful, grant access
                    if viewModel.isLoggedIn {
                        giveLoginAcess = true
                    }
                }, label: {
                    Text("Login")
                        .font(.title2)
                        .bold()
                        .frame(width: 100, height: 40)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                })
            }
            .padding()
            .onAppear {
                viewModel.setupUserCredentials()
            }
        }
    }
}

#Preview {
    LoginScreenView()
}
