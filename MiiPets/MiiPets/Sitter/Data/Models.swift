import Foundation
import UIKit

// MARK: - Models

struct User {
    var userID: String
    var name: String?
    var surname: String?
    var email: String?
    var relationships: [UserRelationship]?
    var acceptedTCS: Bool
    var acceptedPrivacy: Bool
    //
    // TODO: This is not going to be stored. Only kept while allocated 👇
    //
    var profilePicture: String?
    var bio: String?
    var services: [Service]?

    func fullname() -> String {
        return name! + " " + surname!
    }
}

    struct Service {
        var serviceID: String
        var type: ServiceType
        var title: String
        var price: String
        var priceRate: String
        var user: User
        var overview: String?
        //
        // TODO: Not sure how we store location yet. For now we'll show something like 4.8 km
        //
        var location: String?
        //
        // TODO: This is not going to be stored. Only kept while allocated 👇
        //
        var gallery: [String]?
        var allowedPets: [PetType]?
        var numberOfReviews: Int?
        var overallRating: Double?
        var businesHours: [String:String]?
        var reviews: [Review]?
    }

struct Review {
    //
    // TODO: Fill this in
    //
}

// MARK: - Types

enum UserRelationship: String {
    case owner = "Owner"
    case sitter = "Sitter"
}

enum ServiceType: String {
    case walker = "Walker"
    case boarding = "Boarding"
    case houseSitting = "House sitting"
    case daycare = "Daycare"
}

enum PetType: String {
    case dogs = "Dogs"
    case cats = "Cats"
    case birds = "Birds"
    case reptiles = "Reptiles"
    case other = "Other"
}
