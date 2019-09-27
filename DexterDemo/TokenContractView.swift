// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

public protocol TokenContractViewDelegate: class {
  func tokenContractViewDidRequestBalance(_ tokenContractView: TokenContractView)
  func tokenContractViewDidRequestTokenTransfer(_ tokenContractView: TokenContractView)
}

public class TokenContractView: UIView {
  public var delegate: TokenContractViewDelegate?
  
  /// UI Elements in the view.
  /// `stackView` is superView to the other elements.
  private let stackView: UIView
  private let contractAddressLabel: UILabel
  private let addressLabel: UILabel
  private let getBalanceButton: UIButton
  private let transferButton: UIButton

  public init(tokenContractAddress: Address, walletAddress: Address) {
    let stackView = UIStackView()

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center

    let contractAddressLabel = UILabel()
    contractAddressLabel.text = "Token Contract:\n \(tokenContractAddress)"
    contractAddressLabel.numberOfLines = 2
    contractAddressLabel.textAlignment = .center
    contractAddressLabel.textColor = .tezosBlue

    let addressLabel = UILabel()
    addressLabel.text = "Wallet Address:\n\(walletAddress)"
    addressLabel.numberOfLines = 2
    addressLabel.textAlignment = .center
    addressLabel.textColor = .tezosBlue

    let getBalanceButton = UIButton.button(with: "Get Balance")

    let transferButton = UIButton.button(with: "Transfer Tokens")

    self.addressLabel = addressLabel
    self.contractAddressLabel = contractAddressLabel
    self.getBalanceButton = getBalanceButton
    self.transferButton = transferButton

    stackView.frame = UIScreen.main.bounds
    stackView.addArrangedSubview(contractAddressLabel)
    stackView.addArrangedSubview(addressLabel)
    stackView.addArrangedSubview(getBalanceButton)
    stackView.addArrangedSubview(transferButton)

    self.stackView = stackView

    super.init(frame: CGRect.zero)

    getBalanceButton.addTarget(self, action: #selector(getBalancePressed), for: .touchUpInside)
    transferButton.addTarget(self, action: #selector(transferPressed), for: .touchUpInside)

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
  private func getBalancePressed() {
    self.delegate?.tokenContractViewDidRequestBalance(self)
  }

  @objc
  private func transferPressed() {
    self.delegate?.tokenContractViewDidRequestTokenTransfer(self)
  }
}
