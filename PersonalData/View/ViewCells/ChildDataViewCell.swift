import UIKit
import SnapKit

final class ChildDataViewCell: UIView, DataCell {
    // MARK: - Properties
    var delegate: DataViewControllerDelegate?
    static var id = "ChildDataViewCell"
    private var index: Int?

    // MARK: - Subviews Properties
    private lazy var nameEntryView: EntryDataView = {
        let view = EntryDataView(String.Data.name)
        view.layer.borderColor = UIColor.Data.borderTextField.cgColor
        view.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        view.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        view.textField.delegate = self
        return view
    }()

    private lazy var ageEntryView: EntryDataView = {
        let view = EntryDataView(String.Data.age)
        view.textField.keyboardType = .numberPad
        view.layer.borderColor = UIColor.Data.borderTextField.cgColor
        view.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        view.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        view.textField.delegate = self
        return view
    }()

    private lazy var childDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.Data.remove, for: .normal)
        button.setTitleColor(UIColor.Data.removeButton, for: .normal)
        button.addTarget(self, action: #selector(removeChild), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    public convenience init(_ index: Int) {
        self.init()
        self.index = index
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func minusIndex() {
        guard var index = index else { return }
        index -= 1
        self.index = index
    }

    //MARK: - Actions
    @objc func removeChild() {
        guard let index = self.index else {
            return}
        delegate?.removeChild(index: index)
        nameEntryView.textField.text = ""
        ageEntryView.textField.text = ""
    }

    func resetData() {
        nameEntryView.textField.text = ""
        ageEntryView.textField.text = ""
    }

    // MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear

        childDataStackView.addArrangedSubviews(nameEntryView, ageEntryView)
        addSubviews(childDataStackView, removeButton)
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(GlobalConstants.cellWidth)
        }

        nameEntryView.snp.makeConstraints { make in
            make.height.equalTo(GlobalConstants.textFieldHeight)
        }

        ageEntryView.snp.makeConstraints { make in
            make.height.equalTo(GlobalConstants.textFieldHeight)
        }

        childDataStackView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(Constants.childDataStackViewWidth)
        }

        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameEntryView)
            make.left.equalTo(childDataStackView.snp_rightMargin).offset(Constants.removeButtonLeft)
        }
    }
}

// MARK: - Set maximum character in text views
extension ChildDataViewCell: UITextFieldDelegate {
    // MARK: Hide errors
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameEntryView.hideError()
        ageEntryView.hideError()
    }

    // MARK: Check input data
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let range = Range(range, in: text) else {
                return false
        }
        let substringToReplace = text[range]
        let count = text.count - substringToReplace.count + string.count
        switch textField {
        case nameEntryView.textField:
            return CheckData.isNameValid(count: count, str: string, entryView: nameEntryView)
        case ageEntryView.textField:
            return CheckData.isAgeValid(count: count, str: string, entryView: ageEntryView)
        default:
            return false
        }
    }
}

// MARK: - Constants
private extension ChildDataViewCell {
    enum Constants {
        static let childDataStackViewWidth = GlobalConstants.cellWidth / 2
        static let removeButtonLeft = 15
    }
}
