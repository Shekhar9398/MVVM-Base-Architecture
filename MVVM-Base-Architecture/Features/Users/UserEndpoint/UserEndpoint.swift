
import Foundation
enum UserEndpoint: Endpoint {
    case getUserList
    
    var path: String {
        return "/users?page=2"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
