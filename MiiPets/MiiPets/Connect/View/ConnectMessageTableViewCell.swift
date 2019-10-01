import UIKit

class ConnectMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    
    @IBOutlet weak var detailContainerStackView: UIStackView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionContainerView: UIView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailDescriptionShowMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
