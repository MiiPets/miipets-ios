import UIKit

class SitterViewController: UITableViewController {
    
    // MARK: - Constants
    
    private let kTitleHeaderFooterViewReuseIdentifier = "TitleHeaderFooterViewReuseIdentifier"
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredSitters: [Sitter]?
    private let allTheSitters: [Sitter]
    
    // MARK: - Init
    
    override init(style: UITableView.Style) {
        // TODO: Remove
        self.allTheSitters = [Sitter(sitterID: "1234", name: "Stefan", surname: "Bouwer", profilePicture: UIImage(named:"test-profile-picture")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Stefan"),
                              Sitter(sitterID: "1235", name: "Luan", surname: "Stoop", profilePicture: UIImage(named:"test-luan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Luan"),
                              Sitter(sitterID: "1236", name: "Ruan", surname: "van der Merwe", profilePicture: UIImage(named:"test-ruan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Ruan"),
                              Sitter(sitterID: "1237", name: "Ivan", surname: "Stoop", profilePicture: UIImage(named:"test-ivan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Ivan"),
                              Sitter(sitterID: "1238", name: "Fritz", surname: "Poggenpoel", profilePicture: UIImage(named:"test-fritz-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Fritz")]
        
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        // TODO: Remove
        self.allTheSitters = [Sitter(sitterID: "1234", name: "Stefan", surname: "Bouwer", profilePicture: UIImage(named:"test-profile-picture")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Stefan"),
                              Sitter(sitterID: "1235", name: "Luan", surname: "Stoop", profilePicture: UIImage(named:"test-luan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Luan"),
                              Sitter(sitterID: "1236", name: "Ruan", surname: "van der Merwe", profilePicture: UIImage(named:"test-ruan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Ruan"),
                              Sitter(sitterID: "1237", name: "Ivan", surname: "Stoop", profilePicture: UIImage(named:"test-ivan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Ivan"),
                              Sitter(sitterID: "1238", name: "Fritz", surname: "Poggenpoel", profilePicture: UIImage(named:"test-fritz-profile")!.pngData()!.base64EncodedString(), location: nil, bio: "Helli, my name is Fritz")]
        
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.registerTableViews()
        self.setUpSearchViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Configuration and styling
    
    private func style() {
        self.view.backgroundColor = UIColor.white
        self.addTopMiiPetsGreenFadingImage()
    }
}

// MARK: - Tableview

extension SitterViewController {
    
    private func registerTableViews() {
        self.tableView.register(LandingTitleHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: kTitleHeaderFooterViewReuseIdentifier)
    }
}

// MARK: - Table view data source

extension SitterViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTheSitters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: SitterTableViewCell.self, indexPath: indexPath)
        
        cell.update(with: self.sitterFullname(at: indexPath.row), profilePicture: self.sitterProfilePicture(at: indexPath.row))
        
        return cell
    }
}

// MARK: - Table view delegate

extension SitterViewController {
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kTitleHeaderFooterViewReuseIdentifier) as? LandingTitleHeaderFooterView else {
            return nil
        }
        
        header.setTitle("MiiSitter")
        header.updateTopPadding()
        header.updateBottomPadding()
        
        return header
    }
}

// MARK: - Sitter data

extension SitterViewController {
    
    private func setUpSearchViewController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search sitters"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
//        self.searchController.searchBar.scopeButtonTitles = Candy.Category.allCases.map { $0.rawValue }
        self.searchController.searchBar.delegate = self
    }
    
    private func sitterFullname(at index: Int) -> String {
        return self.allTheSitters[index].fullname()
    }
    
    private func sitterProfilePicture(at index: Int) -> UIImage? {
        return UIImage(data: Data(base64Encoded: self.allTheSitters[index].profilePicture!)!)!
    }
}

// MARK: - UISearchBarDelegate

extension SitterViewController: UISearchBarDelegate {
    
}

// MARK: - UISearchResultsUpdating

extension SitterViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

