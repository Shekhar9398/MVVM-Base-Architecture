//import Foundation
//
//// MARK: - Access Token Interceptor
//class AccessTokenInterceptor {
//    // MARK: - Attach Authorization Header
//    static func addAuthorizationHeader(to request: URLRequest) -> URLRequest {
//        var modifiedRequest = request
//        if let accessToken = TokenStorage.shared.getAccessToken() {
//            modifiedRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//            print("[Interceptor] Added Authorization Header: Bearer \(accessToken.prefix(10))...")
//        } else {
//            print("[Interceptor] No Access Token Found, Proceeding Without Authorization Header.")
//        }
//        return modifiedRequest
//    }
//    
//    // MARK: - Handle Token Expiration
//    static func handleTokenExpiration(completion: @escaping (Bool) -> Void) {
//        guard let refreshToken = TokenStorage.shared.getRefreshToken() else {
//            print("[Interceptor] No Refresh Token Found. User must log in again.")
//            completion(false)
//            return
//        }
//
//        let refreshURL = APIConfig.baseURL + APIConfig.refreshTokenEndpoint
//        guard let url = URL(string: refreshURL) else {
//            print("[Interceptor] Invalid Refresh Token URL")
//            completion(false)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // MARK: - API-Specific Body Keys
//        let body = [APIRequestKeys.refreshToken: refreshToken]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//
//        print("[Interceptor] Attempting Token Refresh at: \(refreshURL)")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("[Interceptor] Token Refresh Failed: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
//                print("[Interceptor] No Response or Data From Token Refresh API.")
//                completion(false)
//                return
//            }
//
//            // MARK: - API-Specific Success Code
//            if httpResponse.statusCode == 200 {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    
//                    // MARK: - API-Specific Response Fields
//                    if let newAccessToken = json?[APIResponseKeys.Token.accessToken] as? String,
//                       let newRefreshToken = json?[APIResponseKeys.Token.refreshToken] as? String {
//                        
//                        TokenStorage.shared.setAccessToken(newAccessToken)
//                        TokenStorage.shared.setRefreshToken(newRefreshToken)
//                        print("[Interceptor] Token Refresh Successful: New Access Token Saved.")
//                        completion(true)
//                    } else {
//                        print("[Interceptor] Unexpected Token Response Format")
//                        completion(false)
//                    }
//                } catch {
//                    print("[Interceptor] Token Refresh Response Parsing Failed: \(error.localizedDescription)")
//                    completion(false)
//                }
//            } else {
//                print("[Interceptor] Token Refresh Failed with HTTP Status: \(httpResponse.statusCode)")
//                completion(false)
//            }
//        }
//        task.resume()
//    }
//}

import Foundation

// MARK: - Access Token Interceptor
class AccessTokenInterceptor {
    // MARK: - Attach Authorization Header
    static func addAuthorizationHeader(to request: URLRequest) -> URLRequest {
        var modifiedRequest = request
        if let accessToken = TokenStorage.shared.getAccessToken() {
            modifiedRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            print("[Interceptor] Added Authorization Header: Bearer \(accessToken.prefix(10))...")
        } else {
            print("[Interceptor] No Access Token Found, Proceeding Without Authorization Header.")
        }
        return modifiedRequest
    }
}
