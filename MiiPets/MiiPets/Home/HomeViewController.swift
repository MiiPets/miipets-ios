import UIKit
import SnapKit

fileprivate enum State {
    case closed
    case open
}

fileprivate extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class HomeViewController: UITableViewController {
    
    // MARK: Properties
    
    var animator: UIViewPropertyAnimator!
    
    lazy var miiPetsHeaderView: UIImageView = {
        let headerView = UIImageView(image: UIImage(named: "green_fading_view"))
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        
        return headerView
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        self.addHeaderView()
        
        self.animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
            self.miiPetsHeaderView.transform = CGAffineTransform(scaleX: CGFloat.pi, y: CGFloat.pi)
        })
    }
    
    // MARK: Header and footer views
    
    func addHeaderView() {
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.tableView.frame.size.width, height: self.miiPetsImageViewHeightConstraint))
        self.tableView.tableHeaderView?.backgroundColor = .clear
        
        self.tableView.addSubview(self.miiPetsHeaderView)
        
        self.miiPetsHeaderView.topAnchor.constraint(equalTo: self.tableView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.miiPetsHeaderView.leadingAnchor.constraint(equalTo: self.tableView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.miiPetsHeaderView.trailingAnchor.constraint(equalTo: self.tableView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.miiPetsHeaderView.heightAnchor.constraint(equalToConstant: self.miiPetsImageViewHeightConstraint).isActive = true
    }
}

// MARK: UIScrollViewDelegate

extension HomeViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.animator.fractionComplete = scrollView.contentOffset.y / 100
    }
}
