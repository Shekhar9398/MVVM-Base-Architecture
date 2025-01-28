
import Foundation

struct LoginResponse: Codable {
    let id: Int
    let username: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case token = "accessToken"
    }
}


