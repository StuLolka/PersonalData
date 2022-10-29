import UIKit
import SnapKit

final class ResetViewCell: UIView, DataCell {
    // MARK: - Properties
    var delegate: DataViewControllerDelegate?
    static var id = "ResetViewCell"
    private var index: Int?

    // MARK: - Subviews Properties
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.Data.reset, for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    @objc func showActionSheet() {
        delegate?.showActionSheet()
    }

    // MARK: - Setup view
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(resetButton)
        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(GlobalConstants.cellWidth)
        }
        
        resetButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.width.equalTo(Constants.buttonWidth)
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
          }
    }
}

// MARK: - Constants
private extension ResetViewCell {
    enum Constants {
        static let buttonBorderWidth: CGFloat =  3
        static let buttonCornerRadius: CGFloat = 20
        static let buttonWidth = GlobalConstants.width / 1.75
        static let buttonHeight = 50
    }
}
