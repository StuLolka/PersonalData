import UIKit

protocol DataViewControllerDelegate: UICollectionViewController {
    func addKid()
    func removeKid(index: Int)
    func addResetViewCell()
    func removeResetViewCell()
    func reloadCollectionView()
    func showActionSheet()
    func setIsPersonalDataEntered(_ state: Bool)
}
