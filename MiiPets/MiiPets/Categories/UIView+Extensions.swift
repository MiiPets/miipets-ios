import UIKit

enum UIViewBorderLocation {
    case top
    case left
    case bottom
    case right
}

extension UIView {
    
    private var separatorTag: Int {
        return 101
    }
    
    func addSeparator(to location: UIViewBorderLocation, firstInset: CGFloat = 0.0, secondInset: CGFloat = 0.0) {
        if let separatorView = self.viewWithTag(separatorTag), self.subviews.contains(separatorView) {
            return
        }
        
        let separatorView = UIView(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .separatorColor
        separatorView.tag = self.separatorTag
        
        self.addSubview(separatorView)
        
        switch location {
        case .top:
            separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
            separatorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: firstInset).isActive = true
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: secondInset).isActive = true
        case .left:
            separatorView.widthAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
            separatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: firstInset).isActive = true
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: secondInset).isActive = true
        case .bottom:
            separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: firstInset).isActive = true
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: secondInset).isActive = true
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        case .right:
            separatorView.widthAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
            separatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: firstInset).isActive = true
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: secondInset).isActive = true
        }
    }
}
