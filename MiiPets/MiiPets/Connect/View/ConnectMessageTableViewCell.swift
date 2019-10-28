import UIKit

protocol ConnectMessageDelegate: AnyObject {
    
    func cellNeedsUpdate(at indexPath: IndexPath)
}

class ConnectMessageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    
    @IBOutlet weak var detailContainerStackView: UIStackView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescriptionContainerView: UIView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailDescriptionShowMoreButton: UIButton!
    
    @IBOutlet weak var descriptionLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Constants
    
    private let kDescripionExpandedOffset: CGFloat = 20.0
    private let kDescripionShrinkedOffset: CGFloat = 0.0
    
    // MARK: - Properties
    
    weak var delegate: ConnectMessageDelegate?
    private var indexPath: IndexPath?
    
    // MARK: - Init
    
    static func cell(forIndexPath indexPath: IndexPath, tableView: UITableView, delegate: ConnectMessageDelegate) -> ConnectMessageTableViewCell {
        let identifier = self.stringFromIndexPath(indexPath)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ConnectMessageTableViewCell {
            cell.delegate = delegate
            cell.indexPath = indexPath
            
            return cell
        }
        
        tableView.register(UINib(nibName: "ConnectMessageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: identifier)
        
        guard let registeredCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConnectMessageTableViewCell else {
            return ConnectMessageTableViewCell()
        }
        
        registeredCell.delegate = delegate
        registeredCell.indexPath = indexPath
        
        return registeredCell
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Show more
    
    private var isDescriptionExpanded: Bool {
        return self.detailDescriptionLabel.numberOfLines == 0
    }
    
    @IBAction func didTapShowMoreButton(_ sender: Any) {
        if self.isDescriptionExpanded {
            self.detailDescriptionLabel.numberOfLines = 3
            self.descriptionLabelBottomConstraint.constant = kDescripionShrinkedOffset
            self.detailDescriptionShowMoreButton.setTitle("...Show more", for: .normal)
        } else {
            self.detailDescriptionLabel.numberOfLines = 0
            self.descriptionLabelBottomConstraint.constant = kDescripionExpandedOffset
            self.detailDescriptionShowMoreButton.setTitle("Show less", for: .normal)
        }
        
        if let delegate = self.delegate, let indexPath = self.indexPath {
            delegate.cellNeedsUpdate(at: indexPath)
        }
    }
    
    // MARK: - Convenience
    
    private static func stringFromIndexPath(_ indexPath: IndexPath) -> String {
        return "section:\(indexPath.section)-row:\(indexPath.row)"
    }
}
