import Foundation

// MARK: - API Configuration
struct APIConfig {
    static let baseURL = "https://reqres.in"
    static let refreshTokenEndpoint = "/auth/refresh"
    static let loginEndpoint = "/api/login"
}

// MARK: - API Request Keys
struct APIRequestKeys {
    static let username = "email"
    static let password = "password"
    static let refreshToken = "refresh_token"
}

// MARK: - API Response Keys
struct APIResponseKeys {
    struct Token {
        static let accessToken = "token"
        static let refreshToken = "refresh_token"
    }
}
