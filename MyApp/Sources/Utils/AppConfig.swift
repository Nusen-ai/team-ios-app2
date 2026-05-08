import UIKit

struct AppConfig {

    static let shared = AppConfig()

    var appName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "iOS App 2"
    }

    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }

    var buildNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    struct Flutter {
        static let methodChannelName = "com.shared.components/native_to_flutter"
        static let eventChannelName = "com.shared.components/event_channel"
        static let engineName = "FlutterSharedComponents"
    }

    struct Routes {
        static let login = "/login"
        static let shop = "/shop"
        static let survey = "/survey"

        static let all: [String] = [login, shop, survey]

        static func route(for name: String) -> String? {
            switch name.lowercased() {
            case "login": return login
            case "shop": return shop
            case "survey": return survey
            default: return nil
            }
        }
    }

    private init() {}
}

struct Logger {

    enum Level: String {
        case debug = "🔍 DEBUG"
        case info = "ℹ️ INFO"
        case warning = "⚠️ WARNING"
        case error = "❌ ERROR"
    }

    static func log(_ message: String, level: Level = .debug, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let timestamp = DateFormatter.logFormatter.string(from: Date())
        print("\(timestamp) \(level.rawValue) [\(fileName):\(line)] \(function): \(message)")
        #endif
    }

    static func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }

    static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }

    static func warning(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }

    static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
}

extension DateFormatter {
    static let logFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
}

struct DeviceInfo {

    static func getDeviceInfo() -> [String: Any] {
        let device = UIDevice.current
        return [
            "name": device.name,
            "systemName": device.systemName,
            "systemVersion": device.systemVersion,
            "model": device.model,
            "localizedModel": device.localizedModel,
            "identifierForVendor": device.identifierForVendor?.uuidString ?? "Unknown",
            "isSimulator": isSimulator(),
            "app": "ios_app_2"
        ]
    }

    static func isSimulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
