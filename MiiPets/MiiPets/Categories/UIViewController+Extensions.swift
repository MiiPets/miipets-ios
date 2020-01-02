import UIKit

extension UIViewController {    
    
    private var topAnchorConstant: CGFloat {
        if self is UITableViewController {
            return 50.0
        }
        
        return 10.0
    }
    
    private var miiPetsImageViewHeightConstraint: CGFloat {
        return self.view.frame.width / 2.1
    }
    
    func addTopMiiPetsGreenFadingImage() {
        let greenFadingImageView = UIImageView(image: UIImage(named: "green_fading_view"))
        greenFadingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(greenFadingImageView)
        
        greenFadingImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: -10.0).isActive = true
        greenFadingImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 10.0).isActive = true
        greenFadingImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -self.topAnchorConstant).isActive = true
        greenFadingImageView.heightAnchor.constraint(equalToConstant: self.miiPetsImageViewHeightConstraint).isActive = true
    }
}
