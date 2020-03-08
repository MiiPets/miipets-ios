import UIKit

protocol SitterLandingDelegate: AnyObject {
    
    func reload()
}

class SitterViewModel: NSObject {
    
    // MARK: - Properties
    
    private weak var delegate: SitterLandingDelegate?
    
    private var services: [Service] = []
    
    // MARK: - Init
    
    init(delegate: SitterLandingDelegate) {
        self.delegate = delegate
        super.init()
        self.populateServices()
        
    }
}

// MARK: - Data forwarding

extension SitterViewModel {
    
    var numberOfRows: Int {
        return self.services.count
    }

    func serviceProfilePicture(at index: Int) -> UIImage? {
        return UIImage(data: Data(base64Encoded: self.services[index].gallery!.first!)!)!
    }

    func serviceTitle(at index: Int) -> String {
        return self.services[index].title
    }

    func servicePetsAllowed(at index: Int) -> [PetType]? {
        return self.services[index].allowedPets
    }

    func serviceOverview(at index: Int) -> String? {
        return self.services[index].overview
    }

    func serviceLocation(at index: Int) -> String? {
        return self.services[index].location
    }

    func servicePricing(at index: Int) -> NSAttributedString? {
        let priceMutableAttributedString = NSMutableAttributedString(string: self.services[index].price,
                                                       attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19.0),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.black])
        let extraSpaceAttributedString = NSAttributedString(string: " ")
        let priceRateAttributedString = NSAttributedString(string: self.services[index].priceRate,
                                                           attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0),
                                                           NSAttributedString.Key.foregroundColor: UIColor.black])

        priceMutableAttributedString.append(extraSpaceAttributedString)
        priceMutableAttributedString.append(priceRateAttributedString)

        return priceMutableAttributedString
    }

    func serviceRating(at index: Int) -> String? {
        guard let rating = self.services[index].overallRating else { return nil }
        return String(format:"%.2f", rating)
    }
}

//
// TODO: Remove mock data 👇
//
// MARK: - Populate sitters

extension SitterViewModel {
    
    private func populateServices() {
        let userRuan = User(userID: "1234567890",
                            name: "Ruan",
                            surname: "van der Merwe",
                            email: "ruan@gmail.com",
                            relationships: [.owner, .sitter],
                            acceptedTCS: true,
                            acceptedPrivacy: true,
                            profilePicture: UIImage(named:"test-ruan-profile")!.pngData()!.base64EncodedString(),
                            bio: newSitterBio(with: "Ruan van der Merwe", contactVia: "text message"),
                            services: nil)
        let userIvan = User(userID: "0987654321",
                            name: "Ivan",
                            surname: "Stoop",
                            email: "ivan@gmail.com",
                            relationships: [.owner, .sitter],
                            acceptedTCS: true,
                            acceptedPrivacy: true,
                            profilePicture: UIImage(named:"test-ivan-profile")!.pngData()!.base64EncodedString(),
                            bio: newSitterBio(with: "Ivan Stoop", contactVia: "email"),
                            services: nil)
        let userStefan = User(userID: "6789012345",
                              name: "Stefan",
                              surname: "Bouwer",
                              email: "stefan@gmail.com",
                              relationships: [.owner, .sitter],
                              acceptedTCS: true,
                              acceptedPrivacy: true,
                              profilePicture: UIImage(named:"test-profile-picture")!.pngData()!.base64EncodedString(),
                              bio: newSitterBio(with: "Stefan Bouwer", contactVia: "text message"),
                              services: nil)

        self.services.append(Service(serviceID: "1234",
                                    type: .walker,
                                    title: "Lovely walk on Sea point promanade",
                                    price: "R200",
                                    priceRate: "per day",
                                    user: userRuan,
                                    overview: newOverview(),
                                    location: "Cape Town, Western Cape",
                                    gallery: [UIImage(named:"test-1")!.pngData()!.base64EncodedString()],
                                    allowedPets: [.dogs],
                                    numberOfReviews: 2,
                                    overallRating: 4.3,
                                    businesHours: ["08:00":"12:00"],
                                    reviews: nil))

        self.services.append(Service(serviceID: "5678",
                                    type: .houseSitting,
                                    title: "Reliable day sitter",
                                    price: "R80",
                                    priceRate: "per hour",
                                    user: userRuan,
                                    overview: newOverview(),
                                    location: "Secunda, Mpumulanga",
                                    gallery: [UIImage(named:"test-2")!.pngData()!.base64EncodedString()],
                                    allowedPets: [.dogs, .cats, .birds, .reptiles, .other],
                                    numberOfReviews: 9,
                                    overallRating: 4.9,
                                    businesHours: ["08:00":"17:00"],
                                    reviews: nil))

        self.services.append(Service(serviceID: "9012",
                                    type: .boarding,
                                    title: "Best boarding in the whole of the Western Cape",
                                    price: "R320",
                                    priceRate: "per day",
                                    user: userIvan,
                                    overview: newOverview(),
                                    location: "Burgundy Estate, Western Cape",
                                    gallery: [UIImage(named:"test-3")!.pngData()!.base64EncodedString()],
                                    allowedPets: [.cats],
                                    numberOfReviews: 0,
                                    overallRating: 3.2,
                                    businesHours: ["08:00":"9:00"],
                                    reviews: nil))

        self.services.append(Service(serviceID: "0987",
                                    type: .daycare,
                                    title: "Accrediated daycare specialist",
                                    price: "R20",
                                    priceRate: "per hour",
                                    user: userIvan,
                                    overview: newOverview(),
                                    location: "Sea point, Western Cape",
                                    gallery: [UIImage(named:"test-4")!.pngData()!.base64EncodedString()],
                                    allowedPets: [.dogs, .cats],
                                    numberOfReviews: 223,
                                    overallRating: 4.9,
                                    businesHours: ["08:00":"20:00"],
                                    reviews: nil))

        self.services.append(Service(serviceID: "4321",
                                    type: .houseSitting,
                                    title: "House sitter in the Burgundy Estate area",
                                    price: "R500",
                                    priceRate: "per day",
                                    user: userStefan,
                                    overview: newOverview(),
                                    location: "Cape Town, Western Cape",
                                    gallery: [UIImage(named:"test-5")!.pngData()!.base64EncodedString()],
                                    allowedPets: [.dogs, .cats, .birds],
                                    numberOfReviews: 1,
                                    overallRating: 4.1,
                                    businesHours: ["08:00":"20:00"],
                                    reviews: nil))
    }
    
    private func newSitterBio(with fullname: String, contactVia: String) -> String {
        return "Hello, my name is \(fullname) and I love pets and love taking care of them. Please allow me to look after your pet, while you're away. Please contact me via \(contactVia) and I'll get in touch as soon as possible."
    }

    private func newOverview() -> String {
        return "Does your dog love walks on the beach? Then she/he will love this service! I will take your lovely dog on a walk around the Seapoint promenade (about 2 km). I will adapt to the peace of your dog and return when I see they get too tired. The total time this should take is about 1 hour and I will only charge you for only 1 hour even if it does take a little longer. I will also constantly send updates annd pictures :)."
    }
}

// MARK: - LandingScreenViewModelling

extension SitterViewModel: LandingScreenViewModelling {}
