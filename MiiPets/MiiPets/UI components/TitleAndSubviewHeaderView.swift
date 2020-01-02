import UIKit

class TitleAndSubviewHeaderView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
