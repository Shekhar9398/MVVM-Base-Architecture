
import Foundation

struct TokenResponse: Codable {
    let accessToken, refreshToken: String
    let id: Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
}
