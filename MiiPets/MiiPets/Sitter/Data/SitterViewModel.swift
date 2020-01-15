import UIKit

protocol SitterLandingDelegate: AnyObject {
    
    var isSearchBarEmpty: Bool { get }
    
    func reload()
}

class SitterViewModel: NSObject {
    
    // MARK: - Properties
    
    private weak var delegate: SitterLandingDelegate?
    
    private var sitters: [Sitter] = []
    private var filteredSitters: [Sitter]?
    
    // MARK: - Init
    
    init(delegate: SitterLandingDelegate) {
        self.delegate = delegate
        super.init()
        self.populateSitters()
        
    }
}

// MARK: - Data forwarding

extension SitterViewModel {
    
    var numberOfRows: Int {
        if let delegate = self.delegate, delegate.isSearchBarEmpty {
            return self.sitters.count
        } else {
            return self.filteredSitters?.count ?? 0
        }
    }
    
    func sitterFullname(at index: Int) -> String {
        if let delegate = self.delegate, delegate.isSearchBarEmpty {
            return self.sitters[index].fullname()
        } else {
            guard let sitters = self.filteredSitters else { return "" }
            return sitters[index].fullname()
        }
    }
    
    func sitterProfilePicture(at index: Int) -> UIImage? {
        if let delegate = self.delegate, delegate.isSearchBarEmpty {
            return UIImage(data: Data(base64Encoded: self.sitters[index].profilePicture!)!)!
        } else {
            guard let sitters = self.filteredSitters else { return nil }
            return UIImage(data: Data(base64Encoded: sitters[index].profilePicture!)!)!
        }
    }
    
    func filterSittersWithSearchText(_ searchText: String) {
        self.filteredSitters = self.sitters.filter({ (sitter) -> Bool in
            return sitter.fullname().lowercased().contains(searchText.lowercased())
        })
        
        guard let delegate = self.delegate else { return }
        delegate.reload()
    }
    
    func sitterDescription(at index: Int) -> String? {
        if let delegate = self.delegate, delegate.isSearchBarEmpty {
            return self.sitters[index].bio
        } else {
            guard let sitters = self.filteredSitters else { return "" }
            return sitters[index].bio
        }
    }
}

// MARK: - Populate sitters

extension SitterViewModel {
    
    private func populateSitters() {
        self.sitters.append(Sitter(sitterID: "1234",
                                   name: "Stefan",
                                   surname: "Bouwer",
                                   profilePicture: UIImage(named:"test-profile-picture")!.pngData()!.base64EncodedString(),
                                   location: nil,
                                   bio: self.newSitterBio(with: "Stefan Bouwer", contactVia: "text message")))
        self.sitters.append(Sitter(sitterID: "1235",
                                   name: "Luan",
                                   surname: "Stoop",
                                   profilePicture: UIImage(named:"test-luan-profile")!.pngData()!.base64EncodedString(),
                                   location: nil,
                                   bio: self.newSitterBio(with: "Luan Stoop", contactVia: "email")))
        self.sitters.append(Sitter(sitterID: "1236",
                                   name: "Ruan",
                                   surname: "van der Merwe",
                                   profilePicture: UIImage(named:"test-ruan-profile")!.pngData()!.base64EncodedString(),
                                   location: nil,
                                   bio: self.newSitterBio(with: "Ruan van der Merwe", contactVia: "text message")))
        self.sitters.append(Sitter(sitterID: "1237",
                                   name: "Ivan",
                                   surname: "Stoop",
                                   profilePicture: UIImage(named:"test-ivan-profile")!.pngData()!.base64EncodedString(),
                                   location: nil,
                                   bio: self.newSitterBio(with: "Ivan Stoop", contactVia: "email")))
        self.sitters.append(Sitter(sitterID: "1238",
                                   name: "Fritz",
                                   surname: "Poggenpoel",
                                   profilePicture: UIImage(named:"test-fritz-profile")!.pngData()!.base64EncodedString(),
                                   location: nil,
                                   bio: self.newSitterBio(with: "Fritz Poggenpoel", contactVia: "text message")))
    }
    
    private func newSitterBio(with fullname: String, contactVia: String) -> String {
        return "Hello, my name is \(fullname) and I love pets and love taking care of them. Please allow me to look after your pet, while you're away. Please contact me via \(contactVia) and I'll get in touch as soon as possible."
    }
}

// MARK: - LandingScreenViewModelling

extension SitterViewModel: LandingScreenViewModelling {}