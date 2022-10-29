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

    private lazy var nameTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle(String.Data.name)
        textField.layer.borderColor = UIColor.Data.borderTextField.cgColor
        textField.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        textField.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        textField.addTarget(self, action: #selector(showResetButton), for: .editingDidEnd)
        textField.delegate = self
        return textField
    }()

    private lazy var ageTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle(String.Data.age)
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.Data.borderTextField.cgColor
        textField.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        textField.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        textField.addTarget(self, action: #selector(showResetButton), for: .editingDidEnd)
        textField.delegate = self
        return textField
    }()

    private lazy var personalDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.personalDataSpacing
        return stackView
    }()

    private lazy var kidLabel: UILabel = {
        let label = UILabel()
        label.text = String.Data.children
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.fontSize)
        return label
    }()

    private lazy var addKidButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.buttonImageName), for: .normal)
        button.setTitle(String.Data.addKid, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = Constants.buttonMinimumScaleFactor
        button.setInsets(contentPadding: Constants.buttonContentPadding, imageTitlePadding: Constants.buttonImageTitlePadding)
        button.setTitleColor(UIColor.Data.titleAddKidButton, for: .normal)
        button.layer.borderColor = UIColor.Data.borderAddKidButton.cgColor
        button.tintColor = UIColor.Data.plusAddKidButton
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(addKid), for: .touchUpInside)
        return button
    }()

    private lazy var kidStackView: UIStackView = {
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
    @objc func addKid() {
        delegate?.addKid()
    }

    @objc func showResetButton() {
        guard let name = nameTextField.text, let age = ageTextField.text else { return }
        if name.isEmpty && age.isEmpty {
            delegate?.setIsPersonalDataEntered(false)
            delegate?.removeResetViewCell()
            delegate?.reloadCollectionView()
        } else {
            delegate?.addResetViewCell()
            delegate?.setIsPersonalDataEntered(true)
            delegate?.collectionView.reloadData()
        }
    }

    // MARK: - Methods
    func hideAddKidButton() {
        addKidButton.isHidden = true
    }

    func showAddKidButton() {
        addKidButton.isHidden = false
    }

    func resetData() {
        nameTextField.text = ""
        ageTextField.text = ""
    }

    // MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear

        personalDataStackView.addArrangedSubviews(titleLabel, nameTextField, ageTextField)
        kidStackView.addArrangedSubviews(kidLabel, addKidButton)
        addSubviews(personalDataStackView, kidStackView)
        personalDataStackView.setCustomSpacing(Constants.personalDataCustomSpacing, after: titleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(GlobalConstants.cellWidth)
        }

        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(GlobalConstants.textFieldHeight)
        }

        ageTextField.snp.makeConstraints { make in
            make.height.equalTo(GlobalConstants.textFieldHeight)
        }

        personalDataStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        kidLabel.snp.makeConstraints { make in
            make.width.equalTo(Constants.kidLabelWidth)
        }

        addKidButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.width.equalTo(Constants.buttonWidth)
        }

        kidStackView.snp.makeConstraints { make in
            make.top.equalTo(personalDataStackView.snp_bottomMargin).offset(Constants.kidTopSpace)
            make.bottom.equalToSuperview()
        }
   }
}

// MARK: - Set maximum character in text views
extension PersonalDataViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let range = Range(range, in: text) else {
                return false
        }
        let substringToReplace = text[range]
        let count = text.count - substringToReplace.count + string.count
        switch textField {
        case nameTextField:
            return count <= GlobalConstants.maxNameLength && string.checkStringForLetter()
        case ageTextField:
            return count <= GlobalConstants.maxAgeLength && string.first != "0"
        default:
            return false
        }
    }
}

// MARK: - Constants
private extension PersonalDataViewCell {
    enum Constants {
        static let kidLabelWidth =  GlobalConstants.cellWidth - GlobalConstants.width / 2
        static let buttonHeight = 45
        static let fontSize: CGFloat = 20
        static let buttonWidth = GlobalConstants.width / 2
        static let buttonImageName = "plus"
        static let kidTopSpace = 10
        static let personalDataSpacing: CGFloat = 10
        static let personalDataCustomSpacing: CGFloat = 15
        static let buttonBorderWidth: CGFloat = 2
        static let buttonMinimumScaleFactor = 0.3
        static let buttonCornerRadius: CGFloat = 20
        static let buttonContentPadding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        static let buttonImageTitlePadding: CGFloat = 5
    }
}
