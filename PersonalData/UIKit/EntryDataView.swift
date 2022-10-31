import UIKit
import SnapKit

final class EntryDataView: UIView {
    // MARK: - Subviews Properties
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.TextFielfWithTitle.titleTextField
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.titleFontSize)
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: GlobalConstants.fontName, size: Constants.enterTextFontSize)
        return textField
    }()

    private lazy var error: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = UIColor.TextFielfWithTitle.errorTextColor
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.errorFontSize)
        label.minimumScaleFactor = Constants.minimumScaleFactor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    // MARK: - Init
    public convenience init(_ title: String) {
        self.init()
        setupView(text: title)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func showError(error text: String) {
        error.text = text
        error.isHidden = false
    }

    func hideError() {
        error.isHidden = true
    }

    // MARK: - Setup view
    private func setupView(text: String) {
        title.text = text
        addSubviews(title, textField, error)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.titleTopSpace)
            make.left.equalToSuperview().offset(Constants.leftSpace)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(title).offset(Constants.textFieldTopSpace)
            make.left.equalToSuperview().offset(Constants.leftSpace)
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(Constants.textFielfMinHeight)
        }
        
        error.snp.makeConstraints { make in
            make.top.equalTo(textField.snp_bottomMargin).offset(Constants.errorTopSpace)
            make.left.equalToSuperview().offset(Constants.leftSpace)
            make.right.equalToSuperview().inset(Constants.errorRightSpace)
            make.bottom.equalToSuperview().inset(Constants.errorBottomSpace)
            make.height.greaterThanOrEqualTo(Constants.errorMinHeight)
        }
    }

}

// MARK: - Constants
private extension EntryDataView {
    enum Constants {
        static let titleFontSize: CGFloat = 17
        static let enterTextFontSize: CGFloat = 16
        static let minimumScaleFactor: CGFloat = 0.3
        static let textPaddingTop: CGFloat = 25
        static let rightTextPadding: CGFloat = 0
        static let leftSpace: CGFloat = 20
        static let titleTopSpace = 3
        static let textFieldTopSpace = 5
        static let textFielfMinHeight = 50
        static let errorTopSpace = 2
        static let errorFontSize: CGFloat = 15
        static let errorBottomSpace = 2
        static let errorMinHeight = 15
        static let errorRightSpace = 5
    }
}
