import Foundation

/// MARK: - Authentication Interceptor
class AuthenticationInterceptor: RequestInterceptor {
    
    func intercept(request: URLRequest) -> URLRequest {
        var modifiedRequest = request
        if let token = TokenStorage.shared.getAccessToken() {
            modifiedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("Authorization header added: Bearer \(token)")
        } else {
            print("No access token found.")
        }
        return modifiedRequest
    }
    
    func handleUnauthorizedError(request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        print("Handling unauthorized error for request: \(request)")
        TokenManager.shared.refreshToken { result in
            switch result {
            case .success:
                print("Token refreshed successfully.")
                completion(.success(()))
            case .failure(let error):
                print("Token refresh failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
