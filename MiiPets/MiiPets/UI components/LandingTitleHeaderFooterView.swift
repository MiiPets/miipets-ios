import UIKit

protocol LandingTitleHeaderFooterViewButtonDelegate: AnyObject {
    
    func didTap()
}

class LandingTitleHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: Constants
    
    static let kAdjustedTopPadding: CGFloat = 75.0
    static let kAdjustedBottomPadding: CGFloat = -23.5
    
    // MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var topConstraint: NSLayoutConstraint = {
        return self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100.0)
    }()
    
    lazy var bottomConstraint: NSLayoutConstraint = {
        return self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
    }()
    
    private weak var buttonDelegate: LandingTitleHeaderFooterViewButtonDelegate?
    
    // MARK: Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addAndLayoutTitleLabel()
        self.actionButton.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func addAndLayoutTitleLabel() {
        self.addSubview(self.titleLabel)
        
        self.addConstraint(self.topConstraint)
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        self.addConstraint(self.bottomConstraint)
        self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func updateTopPadding(_ padding: CGFloat = kAdjustedTopPadding) {
        if self.topConstraint.constant != padding {
            self.topConstraint.constant = padding

            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    func updateBottomPadding(_ padding: CGFloat = kAdjustedBottomPadding) {
        if self.bottomConstraint.constant != padding {
            self.bottomConstraint.constant = padding

            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}

// MARK: Right button configuration
 
extension LandingTitleHeaderFooterView {
    
    func configureWithRightButtonImage(_ image: UIImage, delegate: LandingTitleHeaderFooterViewButtonDelegate) {
        self.buttonDelegate = delegate
        
        self.actionButton.isHidden = false
        self.actionButton.setImage(image, for: .normal)
        self.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        self.titleLabel.addSubview(self.actionButton)
        
        self.actionButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
        self.actionButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
    }
    
    @objc private func didTapActionButton() {
        guard let delegate = self.buttonDelegate else { return }
        delegate.didTap()
    }
}
