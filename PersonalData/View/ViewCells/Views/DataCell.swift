import UIKit

protocol DataCell: UIView {
    var delegate: DataViewControllerDelegate? { get set }
}
