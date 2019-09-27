// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

public protocol TokenContractViewDelegate: class {
}

public class TokenContractView: UIView {
  public var delegate: TokenContractViewDelegate?

  /// UI Elements in the view.
  /// `stackView` is superView to the other elements.
  private let stackView: UIView
  private let title: UILabel
  private let addressLabel: UILabel
  private let checkBalanceButton: UIButton
  private let sendMeTezButton: UIButton
  private let queryStorageButton: UIButton
  private let invokeSmartContractButton: UIButton

  public init() {
    let stackView = UIStackView()

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center

    let title = UILabel()
    title.text = "TezosKit Demo"
    title.font = UIFont.systemFont(ofSize: 30)
    title.textColor = .tezosBlue

    let addressLabel = UILabel()
    addressLabel.text = "Wallet Address:\n)"
    addressLabel.numberOfLines = 2
    addressLabel.textAlignment = .center
    addressLabel.textColor = .tezosBlue

    let checkBalanceButton = TokenContractView.button(with: "Check Balance")
    let sendMeTezButton = TokenContractView.button(with: "Send Me Tez")
    let queryStorageButton = TokenContractView.button(with: "Query Smart Contract Storage")
    let invokeSmartContractButton = TokenContractView.button(with: "Invoke Contract")

    self.title = title
    self.addressLabel = addressLabel
    self.checkBalanceButton = checkBalanceButton
    self.sendMeTezButton = sendMeTezButton
    self.queryStorageButton = queryStorageButton
    self.invokeSmartContractButton = invokeSmartContractButton

    stackView.frame = UIScreen.main.bounds
    stackView.addArrangedSubview(title)
    stackView.addArrangedSubview(addressLabel)
    stackView.addArrangedSubview(checkBalanceButton)
    stackView.addArrangedSubview(sendMeTezButton)
    stackView.addArrangedSubview(queryStorageButton)
    stackView.addArrangedSubview(invokeSmartContractButton)

    self.stackView = stackView

    super.init(frame: CGRect.zero)

    checkBalanceButton.addTarget(self, action: #selector(checkBalancePressed), for: .touchUpInside)
    sendMeTezButton.addTarget(self, action: #selector(sendMeTezPressed), for: .touchUpInside)
    queryStorageButton.addTarget(self, action: #selector(queryStoragePressed), for: .touchUpInside)
    invokeSmartContractButton.addTarget(self, action: #selector(invokeSmartContractPressed), for: .touchUpInside)

    self.backgroundColor = .white

    self.addSubview(stackView)

    stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50.0).isActive = true
  }

  public override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: - Button Press Handlers
  @objc
  private func checkBalancePressed() {
  }

  @objc
  private func sendMeTezPressed() {
  }

  @objc
  private func queryStoragePressed() {
  }

  @objc
  private func invokeSmartContractPressed() {
  }

  // MARK: - Private Helpers
  private static func button(with title: String) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.backgroundColor = .tezosBlue
    button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    button.layer.cornerRadius = 5.0
    button.sizeToFit()

    return button
  }
}

extension UIColor {
  public static let tezosBlue = UIColor(red: 62/254, green: 128/254, blue: 234/254, alpha: 1.0)
}
