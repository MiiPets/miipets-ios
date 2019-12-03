import UIKit

// MARK: - ReusableView

protocol ReusableView: class {}

extension ReusableView where Self: UITableViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

// MARK: - UITableView Extension

extension UITableView {
    
    func cell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath) -> CellType {
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? CellType {
            return cell
        }
        register(nib(for: cellType), forCellReuseIdentifier: reuseIdentifier)
        guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
            register(CellType.self, forCellReuseIdentifier: reuseIdentifier)
            guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
                return CellType()
            }
            return registeredCell
        }
        return registeredCell
    }
    
    private func nib<NibType : UIView>(for nibType: NibType.Type) -> UINib {
        return UINib(nibName: String(describing: nibType), bundle: Bundle.main)
    }
}
