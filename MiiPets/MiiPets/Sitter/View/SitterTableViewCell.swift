import UIKit

class SitterTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var profilePictureImageView: UIImageView!
    @IBOutlet private weak var fullnameLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    
    @IBOutlet private weak var separatorViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        self.selectionStyle = .none
        self.separatorViewWidthConstraint.constant = 1 / UIScreen.main.scale
    }
}

// MARK: - Populate

extension SitterTableViewCell {
    
    func update(with fullname: String?, profilePicture: UIImage?) {
        self.fullnameLabel.text = fullname
        self.profilePictureImageView.image = profilePicture
    }
}
