import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = DataFactory.makeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
