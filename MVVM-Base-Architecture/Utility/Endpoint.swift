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

