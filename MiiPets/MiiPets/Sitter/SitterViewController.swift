import UIKit

class SitterViewController: UIViewController {
    
    // MARK: - Constants
    
    private let kTitleHeaderFooterViewReuseIdentifier = "TitleHeaderFooterViewReuseIdentifier"
    
    // MARK: - Properties
    
    private lazy var viewModel: SitterViewModel? = {
        return LandingScreenViewModelResolver.viewmodel(for: .sitter, sitterDelegate: self) as? SitterViewModel
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .default
        searchBar.delegate = self
        searchBar.placeholder = "Search for a sitter"
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
    
    private func configureAndAddSearchBar() {
        self.searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        self.headerView.containerStackView.addArrangedSubview(self.searchBar)
    }
}

// MARK: - Table view data source

extension SitterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: SitterTableViewCell.self,
                                  reuseIdentifier: "SitterTableViewCell:\(indexPath.section)+\(indexPath.row)",
                                  indexPath: indexPath)
        
        cell.delegate = self
        
        if indexPath.row > 0 {
            cell.addSeparator(to: .top, firstInset: 15.0)
        }
        cell.update(with: self.viewModel?.sitterFullname(at: indexPath.row) ?? "N/A",
                    profilePicture: self.viewModel?.sitterProfilePicture(at: indexPath.row),
                    bio: self.viewModel?.sitterDescription(at: indexPath.row) ?? self.userBioEmptyErrorMessage)
        
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

// MARK: - SitterLandingDelegate

extension SitterViewController: SitterLandingDelegate {
    
    var isSearchBarEmpty: Bool {
        return self.searchBar.text?.isEmpty ?? true
    }
    
    func reload() {
        self.tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SitterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.filterSittersWithSearchText(searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let viewModel = self.viewModel else { return }
        
        searchBar.text = ""
        viewModel.filterSittersWithSearchText(searchBar.text!)
        searchBar.resignFirstResponder()
    }
}

// MARK: Other

extension SitterViewController {
    
    private var userBioEmptyErrorMessage: String {
        return "No bio specified"
    }
}
