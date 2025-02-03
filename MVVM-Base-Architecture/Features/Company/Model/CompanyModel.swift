
import Foundation

// MARK: - Welcome
struct CompanyModel: Codable {
        let companyName: String
        let businessID: String
        let domain: String

        enum CodingKeys: String, CodingKey {
            case companyName = "company_name"
            case businessID = "business_id"
            case domain
        }
    }


