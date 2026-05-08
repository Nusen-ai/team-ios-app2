import UIKit
import Flutter

class FlutterNavigator {

    static let shared = FlutterNavigator()

    private init() {}

    func navigateToLogin(
        from viewController: UIViewController,
        arguments: [String: Any]? = nil,
        completion: (() -> Void)? = nil
    ) {
        FlutterEngineManager.shared.navigateToFlutter(
            route: FlutterEngineManager.Routes.login,
            arguments: arguments,
            from: viewController
        )
        completion?()
    }

    func navigateToShop(
        from viewController: UIViewController,
        arguments: [String: Any]? = nil,
        completion: (() -> Void)? = nil
    ) {
        FlutterEngineManager.shared.navigateToFlutter(
            route: FlutterEngineManager.Routes.shop,
            arguments: arguments,
            from: viewController
        )
        completion?()
    }

    func navigateToSurvey(
        from viewController: UIViewController,
        arguments: [String: Any]? = nil,
        completion: (() -> Void)? = nil
    ) {
        FlutterEngineManager.shared.navigateToFlutter(
            route: FlutterEngineManager.Routes.survey,
            arguments: arguments,
            from: viewController
        )
        completion?()
    }

    func navigateTo(
        route: String,
        from viewController: UIViewController,
        arguments: [String: Any]? = nil
    ) {
        FlutterEngineManager.shared.navigateToFlutter(
            route: route,
            arguments: arguments,
            from: viewController
        )
    }

    func sendMessage(method: String, arguments: [String: Any]? = nil) {
        FlutterEngineManager.shared.sendMessageToFlutter(
            method: method,
            arguments: arguments
        )
    }

    func requestDeviceInfo(completion: @escaping ([String: Any]?) -> Void) {
        FlutterEngineManager.shared.sendMessageToFlutter(
            method: "getDeviceInfo",
            arguments: nil
        )
        NotificationCenter.default.addObserver(
            forName: .flutterDeviceInfoReceived,
            object: nil,
            queue: .main
        ) { notification in
            completion(notification.userInfo)
        }
    }
}

extension UIViewController {

    func navigateToFlutterLogin(with arguments: [String: Any]? = nil) {
        FlutterNavigator.shared.navigateToLogin(from: self, arguments: arguments)
    }

    func navigateToFlutterShop(with arguments: [String: Any]? = nil) {
        FlutterNavigator.shared.navigateToShop(from: self, arguments: arguments)
    }

    func navigateToFlutterSurvey(with arguments: [String: Any]? = nil) {
        FlutterNavigator.shared.navigateToSurvey(from: self, arguments: arguments)
    }

    func navigateToFlutter(route: String, with arguments: [String: Any]? = nil) {
        FlutterNavigator.shared.navigateTo(route: route, from: self, arguments: arguments)
    }
}
