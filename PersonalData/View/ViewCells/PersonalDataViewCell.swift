import UIKit
import SnapKit

final class PersonalDataViewCell: UIView, DataCell {
    // MARK: - Properties
    var delegate: DataViewControllerDelegate?
    static var id = "PersonalDataViewCell"
    private var index: Int?
    
    // MARK: - Subviews Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String.Data.title
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.fontSize)
        return label
    }()

    private lazy var nameEntryView: EntryDataView = {
        let view = EntryDataView(String.Data.name)
        view.layer.borderColor = UIColor.Data.borderTextField.cgColor
        view.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        view.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        view.textField.addTarget(self, action: #selector(showResetButton), for: .editingDidEnd)
        view.textField.delegate = self
        return view
    }()

    private lazy var ageEntryView: EntryDataView = {
        let view = EntryDataView(String.Data.age)
        view.textField.keyboardType = .numberPad
        view.layer.borderColor = UIColor.Data.borderTextField.cgColor
        view.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        view.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        view.textField.addTarget(self, action: #selector(showResetButton), for: .editingDidEnd)
        view.textField.delegate = self
        return view
    }()

    private lazy var personalDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.personalDataSpacing
        return stackView
    }()

    private lazy var childLabel: UILabel = {
        let label = UILabel()
        label.text = String.Data.children
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.fontSize)
        return label
    }()

    private lazy var addChildButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.buttonImageName), for: .normal)
        button.setTitle(String.Data.addChild, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = Constants.buttonMinimumScaleFactor
        button.setInsets(contentPadding: Constants.buttonContentPadding, imageTitlePadding: Constants.buttonImageTitlePadding)
        button.setTitleColor(UIColor.Data.titleAddChildButton, for: .normal)
        button.layer.borderColor = UIColor.Data.borderAddChildButton.cgColor
        button.tintColor = UIColor.Data.plusAddChildButton
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(addChild), for: .touchUpInside)
        return button
    }()

    private lazy var childStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @objc func addChild() {
        delegate?.addChild()
    }

    @objc func showResetButton() {
        guard let name = nameEntryView.textField.text, let age = ageEntryView.textField.text else { return }
        if name.isEmpty && age.isEmpty {
            delegate?.setIsPersonalDataEntered(false)
            delegate?.removeResetViewCell()
            delegate?.reloadCollectionView()
        } else {
            delegate?.addResetViewCell()
            delegate?.setIsPersonalDataEntered(true)
            delegate?.reloadCollectionView()
        }
    }

    // MARK: - Methods
    func hideAddChildButton() {
        addChildButton.isHidden = true
    }

    func showAddChildButton() {
        addChildButton.isHidden = false
    }

    func resetData() {
        nameEntryView.textField.text = ""
        ageEntryView.textField.text = ""
    }

    // MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear

        personalDataStackView.addArrangedSubviews(titleLabel, nameEntryView, ageEntryView)
        childStackView.addArrangedSubviews(childLabel, addChildButton)
        addSubviews(personalDataStackView, childStackView)
        personalDataStackView.setCustomSpacing(Constants.personalDataCustomSpacing, after: titleLabel)
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

        personalDataStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        childLabel.snp.makeConstraints { make in
            make.width.equalTo(Constants.childLabelWidth)
        }

        addChildButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.width.equalTo(Constants.buttonWidth)
        }

        childStackView.snp.makeConstraints { make in
            make.top.equalTo(personalDataStackView.snp_bottomMargin).offset(Constants.childTopSpace)
            make.bottom.equalToSuperview()
        }
   }
}

// MARK: - Set maximum character in text views
extension PersonalDataViewCell: UITextFieldDelegate {
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
            return CheckData.isAgeValid(count: count, str: string, entryView: ageEntryView, isChild: false)
        default:
            return false
        }
    }
}

// MARK: - Constants
private extension PersonalDataViewCell {
    enum Constants {
        static let childLabelWidth =  GlobalConstants.cellWidth - GlobalConstants.width / 2
        static let buttonHeight = 45
        static let fontSize: CGFloat = 20
        static let buttonWidth = GlobalConstants.width / 2
        static let buttonImageName = "plus"
        static let childTopSpace = 10
        static let personalDataSpacing: CGFloat = 10
        static let personalDataCustomSpacing: CGFloat = 15
        static let buttonBorderWidth: CGFloat = 2
        static let buttonMinimumScaleFactor = 0.3
        static let buttonCornerRadius: CGFloat = 20
        static let buttonContentPadding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        static let buttonImageTitlePadding: CGFloat = 5
    }
}
