import UIKit
import SnapKit

final class DataViewController: UICollectionViewController {
    // MARK: - Properties
    private var isPersonalDataEntered = false
    private var isChildrenAdded = false

    // MARK: - Subviews Properties
    private lazy var personalDataViewCell = PersonalDataViewCell()
    private lazy var resetViewCell = ResetViewCell()

    private lazy var personalDataCell: [(view: DataCell, id: String)] = [(personalDataViewCell, PersonalDataViewCell.id)]
    private lazy var childrenDataCells: [(view: DataCell, id: String)] = []
    private lazy var resetCell: [(view: DataCell, id: String)] = [(resetViewCell, ResetViewCell.id)]

    private var cells: [(view: DataCell, id: String)] {
        get {
            return personalDataCell + childrenDataCells + resetCell
        }
    }

    // MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        super.init(collectionViewLayout: layout)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup view
    private func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
        collectionView.contentInset = .init(top: 20, left: 0, bottom: 15, right: 0)
        collectionView.backgroundColor = .systemBackground
        resetViewCell.isHidden = true
        registerCells()
    }

    //MARK: - Actions
    @objc func endEditing() {
        view.endEditing(true)
    }

    // MARK: - Methods
    private func registerCells() {
        cells.forEach { self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: $0.id) }
    }
}

// MARK: - Setup cells
extension DataViewController {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells[indexPath.row].id, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.setupCell(view: cells[indexPath.row].view)
        return cell
    }
}

// MARK: - PersonalDataViewControllerDelegate
extension DataViewController: DataViewControllerDelegate {
    func addChild() {
        if !self.isChildrenAdded {
            resetViewCell.isHidden = false
            self.isChildrenAdded = true
        }
        let childrenCount = childrenDataCells.count
        if childrenCount < 5 {
            let index = childrenCount
            childrenDataCells.append((ChildDataViewCell(index), ChildDataViewCell.id + "\(index)"))
            registerCells()
            collectionView.reloadData()
        }
        childrenDataCells.count == 5 ? personalDataViewCell.hideAddChildButton() : personalDataViewCell.showAddChildButton()
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath.init(row: cells.count - 1, section: 0), at: .bottom, animated: true)
      }

    func removeChild(index: Int) {
        childrenDataCells.remove(at: index)
        var index = index
        while index < childrenDataCells.count {
            guard let view = childrenDataCells[index].view as? ChildDataViewCell else { return }
            view.minusIndex()
            index += 1
        }
        personalDataViewCell.showAddChildButton()
        if childrenDataCells.isEmpty {
            isChildrenAdded = false
            removeResetViewCell()
        }
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .bottom, animated: true)
    }

    func addResetViewCell() {
        if !isChildrenAdded && !isPersonalDataEntered {
            resetViewCell.isHidden = false
        }
        registerCells()
    }

    func removeResetViewCell() {
        if !isChildrenAdded && !isPersonalDataEntered {
            resetViewCell.isHidden = true
        }
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    func showActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: String.ActionSheet.reset, style: .default) { [self] (UIAlertAction) in
            childrenDataCells.forEach { (view: DataCell, id: String) in
                guard let view = view as? ChildDataViewCell else { return }
                view.resetData()
            }
            childrenDataCells = []
            resetViewCell.isHidden = true
            personalDataViewCell.resetData()
            personalDataViewCell.showAddChildButton()
            isChildrenAdded = false
            isPersonalDataEntered = false
            collectionView.reloadData()
        })

        alert.addAction(UIAlertAction(title: String.ActionSheet.cancel, style: .cancel))
        present(alert, animated: true)
    }

    func setIsPersonalDataEntered(_ state: Bool) {
        isPersonalDataEntered = state
    }
}

// MARK: - Constants
private extension DataViewController {
    enum Constants {
        static let minimumLineSpacing: CGFloat =  35
    }
}
