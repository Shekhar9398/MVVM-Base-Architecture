import Foundation

protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }

    func createRequest(baseURL: URL) -> URLRequest
}

extension Endpoint {
    func createRequest(baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}

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
