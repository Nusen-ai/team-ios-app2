import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let dashboardViewController = DashboardViewController()
        let navigationController = UINavigationController(rootViewController: dashboardViewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        if let urlContext = connectionOptions.urlContexts.first {
            handleURL(urlContext.url)
        }

        if let notification = connectionOptions.notificationResponse {
            handleNotificationResponse(notification)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        Logger.info("场景断开连接 - App 2")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Logger.info("场景变为活跃 - App 2")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        Logger.info("场景即将变为非活跃 - App 2")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        Logger.info("场景即将进入前台 - App 2")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        Logger.info("场景已进入后台 - App 2")
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleURL(url)
    }

    private func handleURL(_ url: URL) {
        Logger.info("收到URL (App 2): \(url.absoluteString)")

        FlutterEngineManager.shared.handleDeepLink(url: url)

        if url.scheme == "flutterapp2" {
            if let host = url.host {
                switch host {
                case "login":
                    if let rootVC = window?.rootViewController {
                        FlutterNavigator.shared.navigateToLogin(from: rootVC)
                    }
                case "shop":
                    if let rootVC = window?.rootViewController {
                        FlutterNavigator.shared.navigateToShop(from: rootVC)
                    }
                case "survey":
                    if let rootVC = window?.rootViewController {
                        FlutterNavigator.shared.navigateToSurvey(from: rootVC)
                    }
                default:
                    break
                }
            }
        }
    }

    private func handleNotificationResponse(_ response: UNNotificationResponse) {
        let userInfo = response.notification.request.content.userInfo
        Logger.info("收到通知响应 (App 2): \(userInfo)")
    }
}
