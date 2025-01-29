
import SwiftUI

struct LoginScreenView: View {
    @State private var userName = ""
    @State private var passWord = ""
    @State private var giveLoginAcess = false
    
    var body: some View {
        NavigationView{
            VStack {
                ///Mark:- username and password
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
                
                ///Mark:- travel to Homescreen
                NavigationLink(destination: UserView(), isActive: $giveLoginAcess){
                    
                }
                
                ///Mark: - login Button
                Button(action: {
                    if userName == "Shekhar" && passWord == "Shekhar@123" {
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
        }
        
    }
}

#Preview {
    LoginScreenView()
}
