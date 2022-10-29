import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    var view: DataCell?
    var delegate: DataViewControllerDelegate?

    func setupCell(view: DataCell) {
        guard let delegate = delegate else { return }
        self.view = view
        view.delegate = delegate
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
