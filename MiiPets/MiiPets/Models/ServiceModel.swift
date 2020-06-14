import Foundation

enum ServiceType: String {
    case walker = "WALKER"
    case boarding = "BOARDING"
    case houseSitting = "SITTING"
    case daycare = "DAYCARE"
}

enum PetType: String {
    case dogs = "DOGS"
    case cats = "CATS"
    case birds = "BIRDS"
    case reptiles = "REPTILES"
    case other = "OTHER"
}

// MARK: - Models

struct Services: Decodable {
    let services: [Service]
}

struct Service: Decodable {
    let serviceID: String
    let userID: String
    private let serviceType: String
    let title: String?
    let price: String?
    let currency: String?
    let priceRate: String?
    let overview: String?
    let location: String?
    let gallery: [Gallery]?
    let allowedPets: [Pet]?
    let numberOfReviews: Int?
    let overallRating: Double?
    let businessHours: BusinessHours?
    let reviews: String?

    // MARK: CodingKeys

    enum CodingKeys: String, CodingKey {
        case serviceID = "id"
        case userID
        case serviceType = "type"
        case title
        case price
        case currency
        case priceRate
        case overview
        case location
        case gallery
        case allowedPets
        case numberOfReviews
        case overallRating
        case businessHours
        case reviews
    }

    // MARK: Convenience

    var type: ServiceType? {
        return ServiceType(rawValue: serviceType)
    }
}

struct Pet: Decodable {
    private let petType: String

    // MARK: CodingKeys

    enum CodingKeys: String, CodingKey {
        case petType = "type"
    }

    // MARK: Convenience

    var type: PetType? {
        return PetType(rawValue: petType)
    }
}

struct Gallery: Decodable {
    let path: String
}

struct BusinessHours: Decodable {
    let startTime: String
    let endTime: String
}
