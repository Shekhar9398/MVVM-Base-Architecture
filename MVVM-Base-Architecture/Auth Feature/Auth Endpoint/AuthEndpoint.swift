
import Foundation

enum AuthEndpoint: Endpoint {
    case login(username: String, password: String)

    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }

    var method: String {
        return "POST"
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
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

