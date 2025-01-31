
import SwiftUI

struct CastsView: View {
    
    @StateObject var viewModel = CastsViewModel()
    
    var body: some View {
        
        VStack {
            switch viewModel.state {
            case .idle:
                Text("idle")
                    .foregroundStyle(.gray)
            case .loading:
                Text("Please Wait.....")
                    .foregroundStyle(.mint)
            case .data(let casts):
                Text("API Data")
                List{
                    ForEach(casts.data, id: \.self){ expression in
                        Text("\(expression)")
                            .bold()
                            .font(.custom("verdana", size: 24))
                            .padding()
                    }
                }
                .listStyle(.plain)
                
            case .error(let errorMessage):
                Text("Error While Fetching Data\(errorMessage)")
                    .foregroundStyle(.red)
            }
        }
        .onAppear{
            viewModel.fetchCasts()
        }
    }
}

#Preview {
    CastsView()
}
