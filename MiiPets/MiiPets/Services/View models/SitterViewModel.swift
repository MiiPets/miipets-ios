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
    }
}

// MARK: - Data forwarding

extension SitterViewModel {
    
    var numberOfRows: Int {
        return self.services.count
    }

    func serviceProfilePicture(at index: Int) -> UIImage? {
//        if let firstGalleryImageString = self.services[index].gallery?.first,
//            let imageData = Data(base64Encoded: firstGalleryImageString) {
//            return UIImage(data: imageData)
//        }

        return nil
    }

    func serviceTitle(at index: Int) -> String {
        return ""
//        return self.services[index].title
    }

    func servicePetsAllowed(at index: Int) -> [PetType]? {
        return nil
//        return self.services[index].allowedPets
    }

    func serviceOverview(at index: Int) -> String? {
        return self.services[index].overview
    }

    func serviceLocation(at index: Int) -> String? {
        return self.services[index].location
    }

    func servicePricing(at index: Int) -> NSAttributedString? {
        return nil
//        let priceMutableAttributedString = NSMutableAttributedString(string: self.services[index].price,
//                                                       attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19.0),
//                                                                    NSAttributedString.Key.foregroundColor: UIColor.black])
//        let extraSpaceAttributedString = NSAttributedString(string: " ")
//        let priceRateAttributedString = NSAttributedString(string: self.services[index].priceRate,
//                                                           attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0),
//                                                           NSAttributedString.Key.foregroundColor: UIColor.black])
//
//        priceMutableAttributedString.append(extraSpaceAttributedString)
//        priceMutableAttributedString.append(priceRateAttributedString)
//
//        return priceMutableAttributedString
    }

    func serviceRating(at index: Int) -> String? {
        guard let rating = self.services[index].overallRating else { return nil }
        return String(format:"%.2f", rating)
    }
}

// MARK: - LandingScreenViewModelling

extension SitterViewModel: LandingScreenViewModelling {}
