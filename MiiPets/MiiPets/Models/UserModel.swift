import Foundation

enum UserRelationship: String {
    case owner = "OWNER"
    case sitter = "SITTER"
}

// MARK: - Models

struct User: Decodable {
    let userID: String
    let name: String?
    let surname: String?
    let email: String?
    private let userRelationship: String?
    let acceptedTSAndCS: Bool
    let acceptedPrivacy: Bool
    let profilePicturePath: String?
    let bio: String?
    let services: [Service]?

    // MARK: CodingKeys

    enum CodingKeys: String, CodingKey {
        case userID
        case name
        case surname
        case email
        case userRelationship = "relationship"
        case acceptedTSAndCS = "acceptedTsAndCs"
        case acceptedPrivacy
        case profilePicturePath
        case bio
        case services
    }

    // MARK: Convenience

    var relationship: UserRelationship? {
        guard let relationship = userRelationship else { return nil }
        return UserRelationship(rawValue: relationship)
    }

    var fullname: String {
        var fullName = ""
        if let name = name {
            fullName += name
        }
        if let surname = surname {
            if name != nil {
                fullName += " "
            }
            fullName += surname
        }

        return fullName
    }
}
