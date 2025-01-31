
import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}
