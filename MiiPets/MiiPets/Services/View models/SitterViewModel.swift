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

        fetchServices()
    }
}

// MARK: - Fetching anc caching

extension SitterViewModel {

    private func fetchServices() {
        guard let servicesObject = MiiCache.cacher.fetch(Services.self, primaryKey: "loggedInUserID") else { return }
        services.append(contentsOf: servicesObject.services)
    }
}

// MARK: - Data forwarding

extension SitterViewModel {
    
    var numberOfRows: Int {
        return self.services.count
    }

    func serviceProfilePicture(at index: Int) -> UIImage? {
        if let firstGallery = self.services[index].gallery?.first {
            return UIImage(named: firstGallery.path)
        }

        return nil
    }

    func serviceTitle(at index: Int) -> String {
        return self.services[index].title ?? "--"
    }

    func servicePetsAllowed(at index: Int) -> [PetType]? {
        guard let pets = self.services[index].allowedPets else { return nil }
        return pets.compactMap({ $0.type })
    }

    func serviceOverview(at index: Int) -> String? {
        return self.services[index].overview
    }

    func serviceLocation(at index: Int) -> String? {
        return self.services[index].location
    }

    func servicePricing(at index: Int) -> NSAttributedString? {
        if let price = self.services[index].price, let rate = self.services[index].priceRate {
            let priceMutableAttributedString = NSMutableAttributedString(string: price,
                                                                         attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19.0),
                                                                                      NSAttributedString.Key.foregroundColor: UIColor.black])
            let extraSpaceAttributedString = NSAttributedString(string: " ")
            let priceRateAttributedString = NSAttributedString(string: rate,
                                                               attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0),
                                                                            NSAttributedString.Key.foregroundColor: UIColor.black])

            priceMutableAttributedString.append(extraSpaceAttributedString)
            priceMutableAttributedString.append(priceRateAttributedString)

            return priceMutableAttributedString
        }

        return NSAttributedString(string: "N/A")
    }

    func serviceRating(at index: Int) -> String? {
        guard let rating = self.services[index].overallRating else { return nil }
        return String(format:"%.2f", rating)
    }
}

// MARK: - LandingScreenViewModelling

extension SitterViewModel: LandingScreenViewModelling {}
