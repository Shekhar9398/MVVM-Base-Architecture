
import Foundation

enum UserEndpoint: Endpoint {
    case getUserData

    var path: String {
        switch self {
        case .getUserData:
            return "/auth/me"
        }
    }

    var method: String {
        return "GET"
    }

    var headers: [String: String]? {
        return nil
    }

    var body: Data? {
        return nil
    }
}
