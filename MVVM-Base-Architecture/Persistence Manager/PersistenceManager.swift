
import SwiftUI

class PersistenceManager {
    static let shared = PersistenceManager()
    private let userDefaults = UserDefaults.standard

    private init() {}

    func save<T: Codable>(object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Failed to save object: \(error.localizedDescription)")
        }
    }

    func retrieve<T: Codable>(key: String, type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
