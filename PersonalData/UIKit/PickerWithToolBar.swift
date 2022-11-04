import UIKit
import SnapKit

final class PickerWithToolBar: UIView {
    // MARK: - Properties
    var delegate: DataViewControllerDelegate?

    // MARK: - Subviews Properties
    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        return picker
    }()

    private lazy var toolBar: UIToolbar = {
        let bar = UIToolbar()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(hideView))
        button.tintColor = .black
        bar.sizeToFit()
        bar.setItems([button], animated: true)
        return bar
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
        addSubview(toolBar)
        addSubview(picker)
        setupConstraints()
    }

    // MARK: - Set up constraints
    private func setupConstraints() {
        toolBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        picker.snp.makeConstraints { make in
            make.top.equalTo(toolBar.snp_bottomMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}
