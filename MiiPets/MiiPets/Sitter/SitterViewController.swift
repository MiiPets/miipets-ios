import UIKit

class SitterViewController: UITableViewController {
    
    // MARK: - Constants
    
    private let kTitleHeaderFooterViewReuseIdentifier = "TitleHeaderFooterViewReuseIdentifier"
    
    // MARK: - Properties
    
    private lazy var viewModel: SitterViewModel? = {
        return LandingScreenViewModelResolver.viewmodel(for: .sitter, sitterDelegate: self) as? SitterViewModel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        self.style()
    }
    
    // MARK: Configuration and styling
    
    private func configure() {
        self.title = "MiiSitter"
    }
    
    private func style() {
        self.view.backgroundColor = UIColor.white
    }
}

// MARK: - Table view data source

extension SitterViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

extension SitterViewController {
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func reload() {
        self.tableView.reloadData()
    }
}

// MARK: Other

extension SitterViewController {
    
    private var userBioEmptyErrorMessage: String {
        return "No bio specified"
    }
}
