import Foundation

// MARK: - Authentication Manager
class AuthManager {
    static let shared = AuthManager()
    
    private init() {}

    // MARK: - Login and Fetch Access Token
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let loginURL = APIConfig.baseURL + APIConfig.loginEndpoint
        
        guard let url = URL(string: loginURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,  // ✅ Ensure correct key
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        print("[AuthManager] Logging in...")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("[AuthManager] Login Request Failed: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                print("[AuthManager] No Response Data Received.")
                completion(.failure(NetworkError.noData))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    // ✅ Print raw JSON response before parsing
                    if let rawJSON = String(data: data, encoding: .utf8) {
                        print("[AuthManager] Raw Response: \(rawJSON)")
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let accessToken = json?["token"] as? String {  // ✅ Ensure correct key
                        
                        /// ✅ Save tokens to storage (wrap in do-catch)
                        do {
                            TokenStorage.shared.setAccessToken(accessToken)
                            print("[AuthManager] Login Successful. Token Saved.")
                            completion(.success(accessToken))
                        } catch {
                            print("[AuthManager] Failed to save token: \(error.localizedDescription)")
                            completion(.failure(error))
                        }
                        
                    } else {
                        print("[AuthManager] Unexpected Response Format.")
                        completion(.failure(NetworkError.decodingError))
                    }
                } catch {
                    print("[AuthManager] Login Response Parsing Failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else {
                print("[AuthManager] Login Failed with Status Code: \(httpResponse.statusCode)")
                completion(.failure(NetworkError.serverError))
            }
        }.resume()
    }
}

