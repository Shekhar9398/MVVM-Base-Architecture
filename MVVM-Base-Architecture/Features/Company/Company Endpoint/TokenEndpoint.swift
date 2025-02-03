import Foundation
// MARK: - TokenEndpoint
enum TokenEndpoint: Endpoint {
    case login(username: String, password: String)
    case refresh(refreshToken: String)
    
    var path: String {
        switch self {
        case .login:
            return "/token_authentication/login/"   // Updated path
        case .refresh:
            return "/token_authentication/refresh/"   // Updated path
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
                "refresh": refreshToken,
                "expiresInMins": 30
            ]
            return try? JSONSerialization.data(withJSONObject: body, options: [])
        }
    }
}
