import UIKit
import SnapKit

class TextFieldWithTitle: UITextField {
    // MARK: - Properties
    private let textPadding = UIEdgeInsets(
        top: Constants.textPaddingTop,
        left: Constants.leftSpace,
        bottom: Constants.enteringTextBottomSpace,
        right: Constants.rightTextPadding
    )
    // MARK: - Subviews Properties
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Data.titleTextField
        label.font = UIFont(name: GlobalConstants.fontName, size: Constants.fontSize)
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

    // MARK: - Setup view
    private func setupView(text: String) {
        title.text = text
        addSubview(title)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.titleTopSpace)
            make.left.equalToSuperview().offset(Constants.leftSpace)
        }
    }

    // MARK: - Override methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

private extension TextFieldWithTitle {
    enum Constants {
        static let fontSize: CGFloat = 17
        static let textPaddingTop: CGFloat = 25
        static let leftSpace: CGFloat = 20
        static let rightTextPadding: CGFloat = 0
        static let titleTopSpace = 5
        static let enteringTextBottomSpace = 5.0
    }
}
