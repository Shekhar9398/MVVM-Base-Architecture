import Foundation

/// MARK: - Retry Interceptor
class RetryInterceptor: RequestInterceptor {
    private let maxRetryCount: Int
    private let retryDelay: TimeInterval
    private var retryAttempts: [URL: Int] = [:]

    init(maxRetryCount: Int = 3, retryDelay: TimeInterval = 2) {
        self.maxRetryCount = maxRetryCount
        self.retryDelay = retryDelay
        print("RetryInterceptor initialized with maxRetryCount: \(maxRetryCount), retryDelay: \(retryDelay) seconds.")
    }

    func intercept(request: URLRequest) -> URLRequest {
        return request
    }

    func shouldRetry(request: URLRequest, error: Error) -> Bool {
        guard let url = request.url else { return false }
        let currentRetryCount = retryAttempts[url] ?? 0
        if currentRetryCount < maxRetryCount {
            retryAttempts[url] = currentRetryCount + 1
            print("Retry attempt \(currentRetryCount + 1) for request: \(request)")
            return true
        }
        print("Max retry attempts reached for request: \(request)")
        return false
    }

    func retryRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + retryDelay) {
            print("Retrying request: \(request)")
            NetworkManager.shared.session.dataTask(with: request) { data, response, error in
                if let error = error, self.shouldRetry(request: request, error: error) {
                    self.retryRequest(request, completion: completion)
                } else if let data = data {
                    print("Retry successful for request: \(request)")
                    completion(.success(data))
                } else {
                    print("Retry failed for request: \(request) with error: \(error?.localizedDescription ?? "Unknown error")")
                    completion(.failure(error ?? NetworkError.noData))
                }
            }.resume()
        }
    }
}
