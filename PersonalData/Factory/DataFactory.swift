import UIKit

enum DataFactory {
    public static func makeViewController() -> UIViewController {
        let vc = DataViewController()
        return vc
    }
}
