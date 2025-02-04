
import Foundation

class UserRepository {
    private let networkManager = NetworkManager.shared
    private let baseUrl = "https://reqres.in"

    // MARK: - Fetch Casts Data
    func fetchUserList(completion: @escaping (Result<UserListResponse, Error>) -> Void) {
        let endpoint = UserEndpoint.getUserList
        let url = baseUrl + endpoint.path

        print("[CastsRepository] Fetchinng User Data from: \(url)")

        networkManager.request(
            url: url,
            method: endpoint.method.rawValue,
            headers: endpoint.headers,
            responseType: UserListResponse.self,
            completion: completion
        )
    }
}
