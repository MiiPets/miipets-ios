import UIKit

class ConnectLandingCotainerTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private let roundedCardViewHeight: CGFloat = 200
    
    private lazy var roundedCardView: RoundedCardView = {
        let view = RoundedCardView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configure()
        
        self.addAndLayoutCardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configure() {
        self.selectionStyle = .none
    }
    
    // MARK: Layout
    
    private func addAndLayoutCardView() {
        self.addSubview(self.roundedCardView)
        
        self.roundedCardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        self.roundedCardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        self.roundedCardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0).isActive = true
        self.roundedCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        self.roundedCardView.heightAnchor.constraint(equalToConstant: self.roundedCardViewHeight).isActive = true
    }
}
