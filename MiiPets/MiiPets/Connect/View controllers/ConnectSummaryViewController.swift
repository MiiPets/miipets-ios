import UIKit

class ConnectSummaryViewController: UITableViewController {

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: UITableViewDataSource

extension ConnectSummaryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let connectMessageCell = ConnectMessageTableViewCell.cell(forIndexPath: indexPath, tableView: tableView, delegate: self)
        return connectMessageCell
    }
}

// MARK: UITableViewDelegate

extension ConnectSummaryViewController {
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: ConnectMessageDelegate

extension ConnectSummaryViewController: ConnectMessageDelegate {
    
    func cellNeedsUpdate(at indexPath: IndexPath) {
        UIView.performWithoutAnimation {
            self.tableView.reloadData()
        }
    }
}
