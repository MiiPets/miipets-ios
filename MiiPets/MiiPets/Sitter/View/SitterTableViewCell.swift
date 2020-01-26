import UIKit

fileprivate enum State {
    case collapsed
    case expanded
}

protocol SitterTableViewCellDelegate: AnyObject {
    
    var contentWidth: CGFloat { get }
}

class SitterTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private let profileImageCollapsedSize: CGFloat = 60.0
    
    // MARK: - Nib outlets
    
    @IBOutlet private var profilePictureImageView: UIImageView!
    @IBOutlet private var fullnameLabel: UILabel!
    @IBOutlet private var arrowImageView: UIImageView!
    @IBOutlet private var expandedFullNameLabel: UILabel!
    @IBOutlet private var sitterDescription: UILabel!
    @IBOutlet private var separatorView: UIView!
    @IBOutlet private weak var collapsedDetailContainerStackView: UIStackView!
    @IBOutlet private weak var collapsedNameAndLocationStackView: UIStackView!
    @IBOutlet private weak var collapsedLocationLabel: UILabel!
    @IBOutlet private weak var collapsedPriceLabel: UILabel!
    @IBOutlet private weak var collapsedStarImageView: UIImageView!
    @IBOutlet private weak var collapsedRatingLabel: UILabel!
    @IBOutlet private weak var expandedNameContainerStackView: UIStackView!
    @IBOutlet private weak var expandedDescriptionContainerStackView: UIStackView!
    @IBOutlet private weak var expandedLocationLabel: UILabel!
    @IBOutlet private weak var servicesLabel: UILabel!
    @IBOutlet private weak var expandedPriceLabel: UILabel!
    @IBOutlet private weak var expandedRatingLabel: UILabel!
        
    @IBOutlet private var separatorViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - General profile picture constraints
    
    @IBOutlet private var profilePictureHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Collapsed constraints
    
    @IBOutlet private var profilePictureWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureCollapsedTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var arrowCenterYConstrainnt: NSLayoutConstraint!
    @IBOutlet private var arrowCollapsedLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureCollapsedCenterYConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureCollapsedBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureCollapsedTopConstraint: NSLayoutConstraint!
    
    // MARK: - Expanded constraints
    
    @IBOutlet private var profilePictureExpandedTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureExpandedTopConstraint: NSLayoutConstraint!
    @IBOutlet private var profilePictureExpandedBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var arrowExpandedLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var arrowExpandedYConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    weak var delegate: SitterTableViewCellDelegate?
    private var currentState: State = .collapsed
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        self.styleProfilePictureImageView()
    }
    
    // MARK: - Styling and configuration
    
    private func configure() {
        self.selectionStyle = .none
        self.separatorViewWidthConstraint.constant = 1 / UIScreen.main.scale
        self.collapse()
    }
    
    private func styleProfilePictureImageView() {
        self.profilePictureImageView.clipsToBounds = true
        self.profilePictureImageView.layer.masksToBounds = true
        self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.width / 6
    }
}

// MARK: - Populate

extension SitterTableViewCell {
    
    func update(with fullname: String?, profilePicture: UIImage?, bio: String?, distance: String?, price: String?, rating: String?, services: String?) {
        self.fullnameLabel.text = fullname
        self.profilePictureImageView.image = profilePicture
        self.expandedFullNameLabel.text = fullname
        self.sitterDescription.text = bio
        self.collapsedLocationLabel.text = distance
        self.expandedLocationLabel.text = distance
        self.collapsedPriceLabel.text = price
        self.expandedPriceLabel.text = price
        self.collapsedRatingLabel.text = rating
        self.expandedRatingLabel.text = rating
        self.servicesLabel.text = services
    }
}

// MARK: - State handling

extension SitterTableViewCell {
    
    func collapseOrExpand() {
        if self.currentState == .collapsed {
            self.expand()
        } else {
            self.collapse()
        }
    }
    
    private func collapse() {
        // Update state
        
        self.currentState = .collapsed
        
        // Update image views
        
        self.arrowImageView.image = UIImage(named: "downward_arrow")
        
        self.profilePictureImageView.layer.borderWidth = 0.0
        self.profilePictureImageView.layer.borderColor = UIColor.clear.cgColor
        
        // Unhide views
        
        self.collapsedDetailContainerStackView.isHidden = false
        self.profilePictureImageView.isHidden = false
        self.arrowImageView.isHidden = false
        self.separatorView.isHidden = false
        
        // Hide views
        
        self.expandedNameContainerStackView.isHidden = true
        self.expandedDescriptionContainerStackView.isHidden = true
        
        // Disable constraints
        
        self.profilePictureExpandedTrailingConstraint.isActive = false
        self.profilePictureExpandedTopConstraint.isActive = false
        self.profilePictureExpandedBottomConstraint.isActive = false
        self.arrowExpandedLeadingConstraint.isActive = false
        self.arrowExpandedYConstraint.isActive = false
        
        // Enable constraints
        
        self.profilePictureHeightConstraint.isActive = true
        self.profilePictureWidthConstraint.isActive = true
        self.profilePictureCollapsedTrailingConstraint.isActive = true
        self.arrowCenterYConstrainnt.isActive = true
        self.arrowCollapsedLeadingConstraint.isActive = true
        self.profilePictureCollapsedCenterYConstraint.isActive = true
        self.profilePictureCollapsedBottomConstraint.isActive = true
        self.profilePictureCollapsedTopConstraint.isActive = true
        
        // Update constraints
        
        self.profilePictureHeightConstraint.constant = self.profileImageCollapsedSize
        
        // Re-layout
        
        self.layoutIfNeeded()
    }
    
    private func expand() {
        // Update state
        
        self.currentState = .expanded
        
        // Update image views
        
        self.arrowImageView.image = UIImage(named: "upward_arrow")
        
        self.profilePictureImageView.layer.borderWidth = 1 / UIScreen.main.scale
        self.profilePictureImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        // Unhide views
        
        self.profilePictureImageView.isHidden = false
        self.arrowImageView.isHidden = false
        self.expandedNameContainerStackView.isHidden = false
        self.expandedDescriptionContainerStackView.isHidden = false
        
        // Hide views
        
        self.collapsedDetailContainerStackView.isHidden = true
        self.separatorView.isHidden = true
        
        // Disable constraints
        
        self.profilePictureWidthConstraint.isActive = false
        self.profilePictureCollapsedTrailingConstraint.isActive = false
        self.arrowCenterYConstrainnt.isActive = false
        self.arrowCollapsedLeadingConstraint.isActive = false
        self.profilePictureCollapsedCenterYConstraint.isActive = false
        self.profilePictureCollapsedBottomConstraint.isActive = false
        self.profilePictureCollapsedTopConstraint.isActive = false
        
        // Enable constraints
        
        self.profilePictureHeightConstraint.isActive = true
        self.profilePictureExpandedTrailingConstraint.isActive = true
        self.profilePictureExpandedTopConstraint.isActive = true
        self.profilePictureExpandedBottomConstraint.isActive = true
        self.arrowExpandedLeadingConstraint.isActive = true
        self.arrowExpandedYConstraint.isActive = true
        
        // Update constraints
        
        if let delegate = self.delegate {
            self.profilePictureHeightConstraint.constant = (delegate.contentWidth - (15.0 * 2)) / 2
        }
        
        // Re-layout
        
        self.layoutIfNeeded()
    }
}
