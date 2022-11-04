import UIKit

protocol DataViewControllerDelegate {
    func addChild()
    func showCountryPicker()
    func hideCountryPicker()
    func removeChild(index: Int)
    func addResetViewCell()
    func removeResetViewCell()
    func reloadCollectionView()
    func showActionSheet()
    func setIsPersonalDataEntered(_ state: Bool)
}
