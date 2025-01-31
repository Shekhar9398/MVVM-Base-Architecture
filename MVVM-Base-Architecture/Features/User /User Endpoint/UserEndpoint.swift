import Foundation

enum UserEndpoint: Endpoint {
    case getUserData

    var path: String {
        return "/user/me"
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
