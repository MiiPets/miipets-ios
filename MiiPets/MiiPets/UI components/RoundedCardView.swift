import UIKit

class RoundedCardView: UIView {
    
    // MARK: Constants
    
    let kCornerRadius: CGFloat = 10.0
    
    // MARK: Properties
    
    lazy var containerView: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style()
        
        self.addCornerRadius()
        self.addAndLayoutContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.addShadow()
    }
    
    // MARK: Styling
    
    private func style() {
        self.backgroundColor = .clear
        self.containerView.backgroundColor = .white
    }
    
    private func addAndLayoutContainerView() {
        self.addSubview(self.containerView)
        
        self.containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func addCornerRadius() {
        self.containerView.layer.cornerRadius = kCornerRadius
        self.containerView.layer.masksToBounds = true
    }
    
    private func addShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
    }
}
