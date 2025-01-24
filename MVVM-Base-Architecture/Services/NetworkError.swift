
import SwiftUI

enum NetworkError: Error {
    case noData
    case invalidResponse
    case decodingError
    case other(String)   
}
