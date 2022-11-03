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

    private lazy var cityEntryView: EntryDataView = {
        let view = EntryDataView(String.Data.country)
        view.layer.borderColor = UIColor.Data.borderTextField.cgColor
        view.layer.borderWidth = GlobalConstants.textFieldBorderWidth
        view.layer.cornerRadius = GlobalConstants.textFieldCornerRadius
        view.textField.addTarget(self, action: #selector(showResetButton), for: .editingDidEnd)
        view.textField.delegate = self
        return view
    }()

    private lazy var chooseSexTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.TextFielfWithTitle.titleTextField
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.fontSize)
        label.text = String.Data.chooseSex
        label.textAlignment = .center
        return label
    }()

    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.CheckBox.selected, for: .selected)
        button.setImage(UIImage.CheckBox.unselected, for: .normal)
        button.setTitle(String.Data.femaleSex, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(femaleIsSelected), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.chooseSexButtonFontSize)
        return button
    }()

    private lazy var maleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.CheckBox.selected, for: .selected)
        button.setImage(UIImage.CheckBox.unselected, for: .normal)
        button.setTitle(String.Data.maleSex, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(maleIsSelected), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.chooseSexButtonFontSize)
        return button
    }()

    private lazy var sexStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var sexView = UIView()

    private lazy var dateBirthLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.TextFielfWithTitle.titleTextField
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.fontSize)
        label.text = String.Data.dateBirth
        label.textAlignment = .center
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.tintColor = UIColor.DatePicker.datePickerTint
        picker.contentHorizontalAlignment = .center
        picker.maximumDate = Date().tooYoungBornDate()
        picker.minimumDate = Date().tooOldBornDate()
        picker.addTarget(self, action: #selector(datePickerIsSelected), for: .allEvents)
        return picker
    }()

    private lazy var birthView = UIView()

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

    @objc func datePickerIsSelected() {
        datePicker.isSelected = true
        showResetButton()
    }

    @objc func femaleIsSelected() {
        femaleButton.isSelected = !femaleButton.isSelected
        femaleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.chooseSexButtonFontSize)
        maleButton.isSelected = false
        maleButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.chooseSexButtonFontSize)
        showResetButton()
    }

    @objc func maleIsSelected() {
        maleButton.isSelected = !maleButton.isSelected
        femaleButton.isSelected = false
        maleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.chooseSexButtonFontSize)
        femaleButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.chooseSexButtonFontSize)
        showResetButton()
    }

    @objc func showResetButton() {
        guard let name = nameEntryView.textField.text,
              let city = cityEntryView.textField.text else { return }

        if name.isEmpty && city.isEmpty && !femaleButton.isSelected && !maleButton.isSelected && !datePicker.isSelected {
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
        cityEntryView.textField.text = ""
        femaleButton.isSelected = false
        maleButton.isSelected = false
        guard let maximumDate = datePicker.maximumDate else { return }
        datePicker.setDate(maximumDate, animated: true)
    }

    // MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear
        sexView.addSubviews(chooseSexTitle, sexStackView)
        birthView.addSubviews(dateBirthLabel, datePicker)
        sexStackView.addArrangedSubviews(femaleButton, maleButton)
        personalDataStackView.addArrangedSubviews(titleLabel, nameEntryView, cityEntryView, sexView, birthView)
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

        cityEntryView.snp.makeConstraints { make in
            make.height.equalTo(GlobalConstants.textFieldHeight)
        }

        chooseSexTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }

        femaleButton.snp.makeConstraints { make in
            make.width.equalTo(50)
        }

        maleButton.snp.makeConstraints { make in
            make.width.equalTo(femaleButton)
        }

        sexStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(chooseSexTitle.snp_bottomMargin).offset(15)
            make.bottom.equalToSuperview().offset(-10)
        }

        dateBirthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateBirthLabel.snp_bottomMargin).offset(15)
            make.height.equalTo(GlobalConstants.textFieldHeight)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview()
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
        case cityEntryView.textField:
            return true
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
        static let chooseSexButtonFontSize: CGFloat = 17
        static let personalDataSpacing: CGFloat = 10
        static let personalDataCustomSpacing: CGFloat = 15
        static let buttonBorderWidth: CGFloat = 2
        static let buttonMinimumScaleFactor = 0.3
        static let buttonCornerRadius: CGFloat = 20
        static let buttonContentPadding = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        static let buttonImageTitlePadding: CGFloat = 5
    }
}
