import UIKit

class AppointmentsViewController: UITableViewController {
    
    // MARK: Constants
    
    let kTitleHeaderFooterViewReuseIdentifier = "TitleHeaderFooterViewReuseIdentifier"
    
    // MARK: Properties
    
    private lazy var dataSource: AppointmentsDataSource = {
        return AppointmentsDataSource()
    }()
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.addTopMiiPetsGreenFadingImage()
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
    
    // MARK: View registration
    
    private func registerViewsAndCells() {
        self.tableView.register(LandingTitleHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: kTitleHeaderFooterViewReuseIdentifier)
    }
}

// MARK: UITableViewDataSource

extension AppointmentsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.cell(ofType: AppointmentDateSelectionCell.self, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDelegate

extension AppointmentsViewController {
    
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
        
        header.setTitle("MiiPointments")
        header.updateTopPadding()
        
        if let image = UIImage(named: "plus_icon") {
            header.configureWithRightButtonImage(image, delegate: self)
        }
        
        return header
    }
}

// MARK: LandingTitleHeaderFooterViewButtonDelegate

extension AppointmentsViewController: LandingTitleHeaderFooterViewButtonDelegate {
    
    func didTap() {
        debugPrint("Plus button tapped on Appointments landing")
    }
}
