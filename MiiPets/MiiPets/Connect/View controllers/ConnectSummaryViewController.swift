import UIKit

class ConnectSummaryViewController: UITableViewController {
    
    // MARK: Constants
    
    let kConnectMessageCellIdentifier = "ConnectMessageCellIdentifier"

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "ConnectMessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kConnectMessageCellIdentifier)
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
        guard let connectMessageCell = tableView.dequeueReusableCell(withIdentifier: kConnectMessageCellIdentifier) as? ConnectMessageTableViewCell else {
            return UITableViewCell()
        }
        
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
