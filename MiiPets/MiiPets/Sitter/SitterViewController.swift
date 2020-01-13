import UIKit

class SitterViewController: UIViewController {
    
    // MARK: - Constants
    
    private let kTitleHeaderFooterViewReuseIdentifier = "TitleHeaderFooterViewReuseIdentifier"
    
    // MARK: - Properties
    
    private var filteredSitters: [Sitter]?
    private let allTheSitters: [Sitter]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .default
        searchBar.delegate = self
        searchBar.placeholder = "Search sitters"
        searchBar.isTranslucent = true
        searchBar.showsCancelButton = true
        searchBar.tintColor = .miipetsGreen
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private lazy var headerView: TitleAndSubviewHeaderView = {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TitleAndSubviewHeaderView", bundle: bundle)
        let headerView = nib.instantiate(withOwner: self, options: nil).first as! TitleAndSubviewHeaderView
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.titleLabel.text = "MiiSitter"
        
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LandingTitleHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: kTitleHeaderFooterViewReuseIdentifier)
        
        return tableView
    }()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // TODO: Remove
        self.allTheSitters = [Sitter(sitterID: "1234", name: "Stefan", surname: "Bouwer", profilePicture: UIImage(named:"test-profile-picture")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Stefan Bouwer", contactVia: "text message")),
                              Sitter(sitterID: "1235", name: "Luan", surname: "Stoop", profilePicture: UIImage(named:"test-luan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Luan Stoop", contactVia: "email")),
                              Sitter(sitterID: "1236", name: "Ruan", surname: "van der Merwe", profilePicture: UIImage(named:"test-ruan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Ruan van der Merwe", contactVia: "text message")),
                              Sitter(sitterID: "1237", name: "Ivan", surname: "Stoop", profilePicture: UIImage(named:"test-ivan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Ivan Stoop", contactVia: "email")),
                              Sitter(sitterID: "1238", name: "Fritz", surname: "Poggenpoel", profilePicture: UIImage(named:"test-fritz-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Fritz Poggenpoel", contactVia: "text message"))]
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        // TODO: Remove
        self.allTheSitters = [Sitter(sitterID: "1234", name: "Stefan", surname: "Bouwer", profilePicture: UIImage(named:"test-profile-picture")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Stefan Bouwer", contactVia: "text message")),
                              Sitter(sitterID: "1235", name: "Luan", surname: "Stoop", profilePicture: UIImage(named:"test-luan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Luan Stoop", contactVia: "email")),
                              Sitter(sitterID: "1236", name: "Ruan", surname: "van der Merwe", profilePicture: UIImage(named:"test-ruan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Ruan van der Merwe", contactVia: "text message")),
                              Sitter(sitterID: "1237", name: "Ivan", surname: "Stoop", profilePicture: UIImage(named:"test-ivan-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Ivan Stoop", contactVia: "email")),
                              Sitter(sitterID: "1238", name: "Fritz", surname: "Poggenpoel", profilePicture: UIImage(named:"test-fritz-profile")!.pngData()!.base64EncodedString(), location: nil, bio: SitterViewController.newSitterBio(with: "Fritz Poggenpoel", contactVia: "text message"))]
        
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.configureAndAddSubviews()
        self.configureAndAddSearchBar()
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
        
        let headerView = UIView(frame: CGRect(x: 1.0, y: 1.0, width: 1.0, height: 1.0))
        self.tableView.tableHeaderView = headerView
    }
    
    private func configureAndAddSubviews() {
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.tableView)
        
        self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 0.0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
    }
}

// MARK: - Table view data source

extension SitterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearchBarEmpty {
            return self.allTheSitters.count
        } else {
            return self.filteredSitters?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: SitterTableViewCell.self,
                                  reuseIdentifier: "SitterTableViewCell:\(indexPath.section)+\(indexPath.row)",
                                  indexPath: indexPath)
        
        cell.delegate = self
        
        if indexPath.row > 0 {
            cell.addSeparator(to: .top, firstInset: 15.0)
        }
        cell.update(with: self.sitterFullname(at: indexPath.row),
                    profilePicture: self.sitterProfilePicture(at: indexPath.row),
                    bio: self.sitterDescription(at: indexPath.row))
        
        return cell
    }
}

// MARK: - Table view delegate

extension SitterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SitterTableViewCell else { return }
        
        cell.collapseOrExpand()
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - SitterTableViewCellDelegate

extension SitterViewController: SitterTableViewCellDelegate {
    
    var contentWidth: CGFloat {
        return self.tableView.frame.size.width
    }
}

// MARK: - Sitter data

extension SitterViewController {
    
    private var isSearchBarEmpty: Bool {
        return self.searchBar.text?.isEmpty ?? true
    }
    
    private func configureAndAddSearchBar() {
        self.searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        self.headerView.containerStackView.addArrangedSubview(self.searchBar)
    }
    
    private func sitterFullname(at index: Int) -> String {
        if self.isSearchBarEmpty {
            return self.allTheSitters[index].fullname()
        } else {
            guard let sitters = self.filteredSitters else { return "" }
            return sitters[index].fullname()
        }
    }
    
    private func sitterProfilePicture(at index: Int) -> UIImage? {
        if self.isSearchBarEmpty {
            return UIImage(data: Data(base64Encoded: self.allTheSitters[index].profilePicture!)!)!
        } else {
            guard let sitters = self.filteredSitters else { return nil }
            return UIImage(data: Data(base64Encoded: sitters[index].profilePicture!)!)!
        }
    }
    
    private func filterSittersWithSearchText(_ searchText: String) {
        self.filteredSitters = self.allTheSitters.filter({ (sitter) -> Bool in
            return sitter.fullname().lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    private func sitterDescription(at index: Int) -> String? {
        if self.isSearchBarEmpty {
            return self.allTheSitters[index].bio
        } else {
            guard let sitters = self.filteredSitters else { return "" }
            return sitters[index].bio
        }
    }
}

// MARK: - UISearchBarDelegate

extension SitterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterSittersWithSearchText(searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.filterSittersWithSearchText(searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

// MARK: - Mock data that we need to delete

extension SitterViewController {
    
    private static func newSitterBio(with fullname: String, contactVia: String) -> String {
        return "Hello, my name is \(fullname) and I love pets and love taking care of them. Please allow me to look after your pet, while you're away. Please contact me via \(contactVia) and I'll get in touch as soon as possible."
    }
}
