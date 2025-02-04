import Foundation

// MARK: - Casts Repository
class CastsRepository {
    private let networkManager = NetworkManager.shared
    private let baseUrl = "https://klipy-gifs-stickers-clips.p.rapidapi.com"

    // MARK: - Fetch Casts Data
    func fetchCastsData(completion: @escaping (Result<CastsModel, Error>) -> Void) {
        let endpoint = CastsEndpoint.getCastsData
        let url = baseUrl + endpoint.path

        print("[CastsRepository] Fetching Casts Data from: \(url)")

        networkManager.request(
            url: url,
            method: endpoint.method.rawValue,
            headers: endpoint.headers,
            responseType: CastsModel.self,
            completion: completion
        )
    }
}
