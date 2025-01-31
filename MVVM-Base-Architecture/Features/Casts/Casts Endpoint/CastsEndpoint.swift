import Foundation

enum CastsEndpoint: Endpoint {
    case getCastsData
    
    var path: String {
        return "/Lv4AhGjw9VAYXZEOMuUDXF7fqNS3SIFbduFRcfIzwQ0AublWHCVayOyD1cvxL8Xq/clips/categories"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return [
            "x-rapidapi-key": "cb3e09180cmshf4f132c150e5501p19e5c8jsn36daa283fa3a",
            "x-rapidapi-host": "klipy-gifs-stickers-clips.p.rapidapi.com"
        ]
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
