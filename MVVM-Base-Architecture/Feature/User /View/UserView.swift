import SwiftUI

struct UserView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("Idle State")
                    .padding()
                    .foregroundColor(.gray)
            case .loading:
                ProgressView("Loading...")
                    .padding()
            case .data:
                if let user = viewModel.user {
                    VStack(alignment: .center) {
                        // Avatar Image
                        if let imageURL = URL(string: user.image) {
                            AsyncImage(url: imageURL) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 150, height: 150)
                            }
                        }
                        
                        // Name
                        Text("\(user.firstName) \(user.lastName)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // Username
                        Text("Username: \(user.username)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                        
                        // Email
                        Text("Email: \(user.email)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                        
                        // Gender
                        Text("Gender: \(user.gender.capitalized)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 10))
                    .padding(.horizontal)
                }
            case .error:
                Text(viewModel.errorMessage ?? "Something went wrong.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchToken(username: "emilys", password: "emilyspass")
        }
        .navigationTitle("User Profile")
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)) 
    }
}
