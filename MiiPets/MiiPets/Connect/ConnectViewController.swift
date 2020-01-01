import UIKit

class ConnectViewController: UITableViewController {
    
    // MARK: Constants
    
    private let kContainerCellReuseIdentifier = "ContainerCellReuseIdentifier"
    private let kTitleHeaderFooterViewReuseIdentifier = "TitleHeaderFooterViewReuseIdentifier"
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.registerViewsAndCells()
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
    
    // MARK: UITableView
    
    private func registerViewsAndCells() {
        self.tableView.register(ConnectLandingCotainerTableViewCell.self, forCellReuseIdentifier: kContainerCellReuseIdentifier)
        self.tableView.register(LandingTitleHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: kTitleHeaderFooterViewReuseIdentifier)
    }
}

// MARK: UITableViewDataSource

extension ConnectViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kContainerCellReuseIdentifier) as? ConnectLandingCotainerTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ConnectSummaryViewController(style: .grouped)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: UITableViewDelegate

extension ConnectViewController {
    
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
        
        header.setTitle("MiiConnect")
        header.updateTopPadding()
        header.updateBottomPadding()
        
        return header
    }
}
