import UIKit

class DashboardViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS App 2 - 控制台"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "企业级Flutter共享组件演示"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginButton: UIButton = {
        let button = createButton(title: "登录", systemImage: "person.circle", color: .systemBlue)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()

    private lazy var shopButton: UIButton = {
        let button = createButton(title: "商城", systemImage: "cart", color: .systemGreen)
        button.addTarget(self, action: #selector(shopTapped), for: .touchUpInside)
        return button
    }()

    private lazy var surveyButton: UIButton = {
        let button = createButton(title: "问卷", systemImage: "doc.text", color: .systemOrange)
        button.addTarget(self, action: #selector(surveyTapped), for: .touchUpInside)
        return button
    }()

    private lazy var testButton: UIButton = {
        let button = createButton(title: "测试通信", systemImage: "antenna.radiowaves.left.and.right", color: .systemPurple)
        button.addTarget(self, action: #selector(testCommunication), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotifications()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "iOS App 2"

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(loginButton)
        contentView.addSubview(shopButton)
        contentView.addSubview(surveyButton)
        contentView.addSubview(testButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 56),

            shopButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            shopButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            shopButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            shopButton.heightAnchor.constraint(equalToConstant: 56),

            surveyButton.topAnchor.constraint(equalTo: shopButton.bottomAnchor, constant: 16),
            surveyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            surveyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            surveyButton.heightAnchor.constraint(equalToConstant: 56),

            testButton.topAnchor.constraint(equalTo: surveyButton.bottomAnchor, constant: 32),
            testButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            testButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            testButton.heightAnchor.constraint(equalToConstant: 56),
            testButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLoginSuccess(_:)),
            name: .flutterLoginSuccess,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePageNavigation(_:)),
            name: .flutterPageNavigation,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDeviceInfoReceived(_:)),
            name: .flutterDeviceInfoReceived,
            object: nil
        )
    }

    private func createButton(title: String, systemImage: String, color: UIColor) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = UIImage(systemName: systemImage)
        config.imagePadding = 12
        config.baseBackgroundColor = color
        config.cornerStyle = .large

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    @objc private func loginTapped() {
        navigateToFlutterLogin(with: ["source": "ios_app_2", "action": "login"])
    }

    @objc private func shopTapped() {
        navigateToFlutterShop(with: ["source": "ios_app_2", "action": "shop"])
    }

    @objc private func surveyTapped() {
        navigateToFlutterSurvey(with: ["source": "ios_app_2", "action": "survey"])
    }

    @objc private func testCommunication() {
        FlutterNavigator.shared.sendMessage(method: "getDeviceInfo", arguments: [
            "requestId": UUID().uuidString,
            "source": "ios_app_2"
        ])
        showAlert(title: "通信测试", message: "已发送测试消息到Flutter")
    }

    @objc private func handleLoginSuccess(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            print("App 2 - 收到登录成功: \(userInfo)")
            showAlert(title: "登录成功", message: "UserID: \(userInfo["userId"] ?? "N/A")")
        }
    }

    @objc private func handlePageNavigation(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let page = userInfo["page"] as? String {
            print("App 2 - Flutter页面导航: \(page)")
        }
    }

    @objc private func handleDeviceInfoReceived(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            print("App 2 - 收到设备信息: \(userInfo)")
            showAlert(title: "设备信息", message: "\(userInfo)")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}
