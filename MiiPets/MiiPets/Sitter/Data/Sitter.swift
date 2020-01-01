import Foundation

struct Sitter {
    var sitterID: String
    var name: String?
    var surname: String?
    var profilePicture: String?
    var location: String? // Not sure how we store location yet
    var bio: String?
    
    func fullname() -> String {
        return name! + " " + surname!
    }
}
