import Foundation

enum AuthEndpoint: Endpoint {
    case login(username: String, password: String)

    var path: String {
        return "/auth/login"
    }

    var method: HTTPMethod {
        return .POST
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var queryParameters: [String: String]? {
        return nil
    }

    var body: Data? {
        switch self {
        case .login(let username, let password):
            let body: [String: Any] = [
                "username": username,
                "password": password,
                "expiresInMins": 30
            ]
            return try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    }
}
