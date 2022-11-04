import UIKit

extension UIColor {
    enum Data {
        static let borderAddChildButton: UIColor = UIColor(named: "borderAddChildButton") ?? .systemBlue
        static let plusAddChildButton: UIColor = UIColor(named: "plusAddChildButton") ?? .systemBlue
        static let removeButton: UIColor = UIColor(named: "removeButton") ?? .systemBlue
        static let resetButton: UIColor = UIColor(named: "resetButton") ?? .systemRed
        static let titleAddChildButton: UIColor = UIColor(named: "titleAddChildButton") ?? .systemBlue
        static let borderTextField: UIColor = UIColor(named: "borderTextField") ?? .lightGray
    }
    enum TextFielfWithTitle {
        static let errorTextColor: UIColor = UIColor(named: "errorTextColor") ?? .red
        static let titleTextField: UIColor = UIColor(named: "titleTextField") ?? .lightGray
    }

    enum PickerWithToolBar {
        static let backgroundToolBar: UIColor = UIColor(named: "backgroundToolBar") ?? .systemGray6
    }

    enum DatePicker {
        static let datePickerTint: UIColor = UIColor(named: "datePickerTint") ?? .lightGray
    }
}
