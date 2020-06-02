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
    case owner = "OWNER"
    case sitter = "SITTER"
}

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
