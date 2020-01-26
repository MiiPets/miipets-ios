import Foundation

struct Sitter {
    var sitterID: String
    var name: String?
    var surname: String?
    var profilePicture: String?
    var location: String? // Not sure how we store location yet. For now we'll show something like 4.8 km
    var bio: String?
    var rating: Double
    var price: Double
    var services: [String]
    
    func fullname() -> String {
        return name! + " " + surname!
    }
}
