import Foundation

enum TokenEndpoint: Endpoint {
    case login(username: String, password: String)
    case refresh(refreshToken: String)

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .refresh: return "/auth/refresh"
        }
    }

    var method: HTTPMethod {
        return .post
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

        case .refresh(let refreshToken):
            let body: [String: Any] = [
                "refreshToken": refreshToken,
                "expiresInMins": 30
            ]
            return try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    }
}
