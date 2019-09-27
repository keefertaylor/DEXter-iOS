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
  private let addressLabel: UILabel
  private let getBalanceButton: UIButton

  public init(tokenContractAddress: Address) {
    let stackView = UIStackView()

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center

    let addressLabel = UILabel()
    addressLabel.text = "Token Contract:\n \(tokenContractAddress)"
    addressLabel.numberOfLines = 2
    addressLabel.textAlignment = .center
    addressLabel.textColor = .tezosBlue

    let getBalanceButton = UIButton.button(with: "Get Balance")

    self.addressLabel = addressLabel
    self.getBalanceButton = getBalanceButton

    stackView.frame = UIScreen.main.bounds
    stackView.addArrangedSubview(addressLabel)
    stackView.addArrangedSubview(getBalanceButton)

    self.stackView = stackView

    super.init(frame: CGRect.zero)

    getBalanceButton.addTarget(self, action: #selector(getBalancePressed), for: .touchUpInside)

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
  }
}
