import Foundation

class CastsRepository {
    private let networkManager = NetworkManager.shared

    func fetchCastsData(completion: @escaping (Result<CastsModel, Error>) -> Void) {
        let endpoint = CastsEndpoint.getCastsData
        
        networkManager.request(
            baseURL: "https://klipy-gifs-stickers-clips.p.rapidapi.com",
            endpoint: endpoint.path,
            method: endpoint.method,
            parameters: endpoint.queryParameters,
            headers: endpoint.headers,
            responseType: CastsModel.self
        ) { result in
            switch result {
            case .success(let castsData):
                completion(.success(castsData))
                print("Casts Data Fetched Successfully: \(castsData)")
                
            case .failure(let error):
                print("Network Request Failed: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
