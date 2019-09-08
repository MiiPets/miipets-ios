import UIKit

class MainNavigationController: UINavigationController {
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
    }
    
    // MARK: Styling
    
    func style() {
        self.isNavigationBarHidden = true
    }
}
