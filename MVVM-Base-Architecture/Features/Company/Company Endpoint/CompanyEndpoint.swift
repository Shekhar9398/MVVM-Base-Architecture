import Foundation

// MARK: - CompanyEndpoint
enum CompanyEndpoint: Endpoint {
    case getCompanies(query: [String: String]?)
    
    var path: String {
        switch self {
        case .getCompanies:
            return "/companies/"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .getCompanies(let query):
            return query
        }
    }
    
    var body: Data? {
        return nil
    }
}
