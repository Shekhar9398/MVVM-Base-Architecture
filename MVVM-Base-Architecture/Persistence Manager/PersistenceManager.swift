import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    private let userDefaults = UserDefaults.standard

    private init() {}

    ///Mark:-  Save to UserDefaults (For non-sensitive data)
    func save<T: Codable>(object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Failed to save object: \(error.localizedDescription)")
        }
    }

    ///Mark:-  Retrieve from UserDefaults
    func retrieve<T: Codable>(key: String, type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
