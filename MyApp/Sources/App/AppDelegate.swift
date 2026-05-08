import UIKit
import Flutter

@main
class AppDelegate: FlutterAppDelegate {

    private var flutterEngine: FlutterEngine?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if let flutterEngine = FlutterEngineManager.shared.engine {
            self.flutterEngine = flutterEngine
            NSLog("Flutter引擎已预初始化 - App 2")
        }

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        NSLog("设备Token (App 2): \(token)")

        FlutterEngineManager.shared.sendMessageToFlutter(
            method: "onDeviceTokenReceived",
            arguments: ["token": token, "app": "ios_app_2"]
        )

        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    override func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        NSLog("推送注册失败 (App 2): \(error.localizedDescription)")
        super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        if url.scheme == "flutterapp2" {
            FlutterEngineManager.shared.handleDeepLink(url: url)
            return true
        }
        return super.application(app, open: url, options: options)
    }
}
