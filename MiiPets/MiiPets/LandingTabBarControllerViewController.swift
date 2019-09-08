import UIKit

class LandingTabBarControllerViewController: UITabBarController {
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setInitialTabbarItem()
    }
    
    // MARK: Tabbar
    
    func setInitialTabbarItem() {
        self.selectedIndex = 2
    }
}
