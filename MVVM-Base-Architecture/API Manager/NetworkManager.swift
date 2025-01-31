import Foundation

///Mark:- API Client
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func request<T: Codable>(
        baseURL: String,
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        requiresAuth: Bool = false,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = baseURL + endpoint
        NetworkHelper.sendRequest(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers,
            requiresAuth: requiresAuth,
            responseType: responseType,
            completion: completion
        )
    }
}
