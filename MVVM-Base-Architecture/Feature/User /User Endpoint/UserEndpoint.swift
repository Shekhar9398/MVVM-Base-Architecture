import Foundation

enum UserEndpoint: Endpoint {
    case getUserData

    var path: String {
        return "/auth/me"
    }

    var method: HTTPMethod {
        return .GET
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
