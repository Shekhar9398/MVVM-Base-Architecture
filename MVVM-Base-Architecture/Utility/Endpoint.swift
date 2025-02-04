import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    func createRequest(baseURL: URL) -> URLRequest
}

extension Endpoint {
    func createRequest(baseURL: URL) -> URLRequest {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        
        ///Mark:-  Add query parameters for GET requests
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let finalURL = urlComponents?.url else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue

      ///Mark:- Add body for POST/PUT/PATCH requests
        if let body = body {
            request.httpBody = body
        }

        ///Mark:- Add headers if needed
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }

        return request
    }
}

