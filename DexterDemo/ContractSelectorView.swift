// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

public protocol ContractSelectorViewDelegate: class {
  func contractSelectorViewRequestedOpenTokenContract(_ contractSelectorView: ContractSelectorView)
  func contractSelectorViewRequestedOpenExchangeContract(_ contractSelectorView: ContractSelectorView)
}

public class ContractSelectorView: UIView {
  public var delegate: ContractSelectorViewDelegate?
  
  /// UI Elements in the view.
  /// `stackView` is superView to the other elements.
  private let stackView: UIView
  private let tokenContractButton: UIButton
  private let exchangeContractButton: UIButton

  public init() {
    let stackView = UIStackView()

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center

    self.tokenContractButton = UIButton.button(with: "Token Contract")
    self.exchangeContractButton = UIButton.button(with: "Exchange Contract")

    stackView.frame = UIScreen.main.bounds
    stackView.addArrangedSubview(tokenContractButton)
    stackView.addArrangedSubview(exchangeContractButton)
    self.stackView = stackView

    super.init(frame: CGRect.zero)

    tokenContractButton.addTarget(self, action: #selector(tokenContractPressed), for: .touchUpInside)
    exchangeContractButton.addTarget(self, action: #selector(exchangeContractPressed), for: .touchUpInside)

    self.backgroundColor = .white

    stackView.sizeToFit()
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
  private func tokenContractPressed() {
    self.delegate?.contractSelectorViewRequestedOpenTokenContract(self)
  }

  @objc
  private func exchangeContractPressed() {
    self.delegate?.contractSelectorViewRequestedOpenExchangeContract(self)
  }
}
