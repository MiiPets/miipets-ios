import UIKit

class ConnectViewController: UITableViewController {
    
    // MARK: Constants
    
    let kContainerCellReuseIdentifier = "ContainerCellReuseIdentifier"
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        self.registerViewsAndCells()
    }
    
    // MARK: Styling
    
    private func style() {
        self.view.backgroundColor = UIColor.white
        self.addTopMiiPetsGreenFadingImage()
    }
    
    // MARK: UITableView
    
    private func registerViewsAndCells() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: kContainerCellReuseIdentifier)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kContainerCellReuseIdentifier) else {
            return UITableViewCell()
        }
        
        return cell
    }
}
