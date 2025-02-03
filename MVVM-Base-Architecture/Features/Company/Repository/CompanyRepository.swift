import Foundation

class CompanyRepository {
    private let networkManager = NetworkManager.shared
    private let baseUrl = "https://api.vainu.io/api/v2/token_authentication"
    
    let queryParameters: [String: String] = [
        "country": "FI",
        "company_name__startswith": "vainu finland oy",
        "limit": "1",
        "fields": "company_name,business_id,domain"
    ]

    
    func fetchUserData(completion: @escaping (Result<CompanyModel, Error>) -> Void) {
        let endpoint = CompanyEndpoint.getCompanies(query: queryParameters)
        
        networkManager.request(
            baseURL: baseUrl,
            endpoint: endpoint.path,
            responseType: CompanyModel.self
        ) { result in
            completion(result)
        }
    }
}
