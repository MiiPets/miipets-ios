import UIKit

class LandingTitleHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: Constants
    
    static let kAdjustedTopPadding: CGFloat = 70.0
    
    // MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 35.0)
        
        return label
    }()
    
    lazy var topConstraint: NSLayoutConstraint = {
        return self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100.0)
    }()
    
    // MARK: Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addAndLayoutTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func addAndLayoutTitleLabel() {
        self.addSubview(self.titleLabel)
        
        self.addConstraint(self.topConstraint)
        self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
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
}
