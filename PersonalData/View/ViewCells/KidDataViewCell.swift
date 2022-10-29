import UIKit
import SnapKit

final class KidDataViewCell: UIView, DataCell {
    // MARK: - Properties
    var delegate: DataViewControllerDelegate?
    static var id = "KidDataViewCell"
    private var index: Int?

    // MARK: - Subviews Properties
    private lazy var nameTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle(String.Data.name)
        textField.layer.borderColor = UIColor.Data.borderTextField.cgColor
        textField.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        textField.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        textField.delegate = self
        return textField
    }()

    private lazy var ageTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle(String.Data.age)
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.Data.borderTextField.cgColor
        textField.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        textField.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        textField.delegate = self
        return textField
    }()

    private lazy var kidDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.Data.remove, for: .normal)
        button.setTitleColor(UIColor.Data.removeButton, for: .normal)
        button.addTarget(self, action: #selector(removeKid), for: .touchUpInside)
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
    @objc func removeKid() {
        guard let index = self.index else { return }
        delegate?.removeKid(index: index)
        nameTextField.text = ""
        ageTextField.text = ""
    }

    // MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear

        kidDataStackView.addArrangedSubviews(nameTextField, ageTextField)
        addSubviews(kidDataStackView, removeButton)
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

        kidDataStackView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(Constants.kidDataStackViewWidth)
        }

        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameTextField)
            make.left.equalTo(kidDataStackView.snp_rightMargin).offset(Constants.removeButtonLeft)
        }
    }
}

// MARK: - Set maximum character in text views
extension KidDataViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let range = Range(range, in: text) else {
                return false
        }
        let substringToReplace = text[range]
        let count = text.count - substringToReplace.count + string.count
        switch textField {
        case nameTextField:
            return count <= GlobalConstants.maxNameLength
        case ageTextField:
            return count <= GlobalConstants.maxAgeLength
        default:
            return false
        }
    }
}

// MARK: - Constants
private extension KidDataViewCell {
    enum Constants {
        static let kidDataStackViewWidth = GlobalConstants.cellWidth / 2
        static let removeButtonLeft = 15
    }
}
