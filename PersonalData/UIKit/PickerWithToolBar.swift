import UIKit
import SnapKit

final class PickerWithToolBar: UIView {
    // MARK: - Properties
    var delegate: DataViewControllerDelegate?

    // MARK: - Subviews Properties
    lazy var picker = UIPickerView()

    private lazy var test: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PickerWithToolBar.backgroundToolBar
        return view
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(hideView), for: .touchUpInside)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonTitleFontSize)
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

    // MARK: - Actions
    @objc func hideView() {
        delegate?.hideCountryPicker()
    }

    // MARK: - Set up view
    private func setupView() {
        backgroundColor = .white
        test.addSubview(doneButton)
        addSubview(test)
        addSubview(picker)
        setupConstraints()
    }

    // MARK: - Set up constraints
    private func setupConstraints() {
        test.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(35)
        }

        doneButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        picker.snp.makeConstraints { make in
            make.top.equalTo(test.snp_bottomMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Constants
extension PickerWithToolBar {
    enum Constants {
        static let buttonTitleFontSize: CGFloat = 15
    }
}
