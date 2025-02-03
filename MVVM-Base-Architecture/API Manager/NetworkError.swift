
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data was returned from the server."
        case .decodingError:
            return "The data could not be decoded."
        case .serverError(let message):
            return "Server Error: \(message)"
        }
    }
}
