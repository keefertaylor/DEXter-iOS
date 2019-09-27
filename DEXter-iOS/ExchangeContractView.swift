// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

public protocol ExchangeContractViewDelegate: class {
  func exchangeClientViewDidRequestTotalBalanceTez(_ exchangeClientView: ExchangeContractView)
  func exchangeClientViewDidRequestTotalBalanceTokens(_ exchangeClientView: ExchangeContractView)
  func exchangeClientViewDidRequestTotalLiquidity(_ exchangeClientView: ExchangeContractView)
  func exchangeClientViewDidRequestAddLiquidity(_ exchangeClientView: ExchangeContractView)
  func exchangeClientViewDidRequestWithdrawLiquidity(_ exchangeClientView: ExchangeContractView)
  func exchangeClientViewDidRequestBuyTez(_ exchangeClientView: ExchangeContractView)
  func exchangeClientViewDidRequestBuyTokens(_ exchangeClientView: ExchangeContractView)
}

public class ExchangeContractView: UIView {
  public var delegate: ExchangeContractViewDelegate?
  
  /// UI Elements in the view.
  /// `stackView` is superView to the other elements.
  private let stackView: UIView
  private let contractAddressLabel: UILabel
  private let addressLabel: UILabel
  private let getTotalBalanceTezButton: UIButton
  private let getTotalBalanceTokensButton: UIButton
  private let getTotalLiquidityButton: UIButton
  private let addLiquidityButton: UIButton
  private let withdrawLiquidityButton: UIButton
  private let buyTezButton: UIButton
  private let buyTokensButton: UIButton

  public init(exchangeContractAddress: Address, walletAddress: Address) {
    let stackView = UIStackView()

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center

    let contractAddressLabel = UILabel()
    contractAddressLabel.text = "Token Contract:\n \(exchangeContractAddress)"
    contractAddressLabel.numberOfLines = 2
    contractAddressLabel.textAlignment = .center
    contractAddressLabel.textColor = .tezosBlue

    let addressLabel = UILabel()
    addressLabel.text = "Wallet Address:\n\(walletAddress)"
    addressLabel.numberOfLines = 2
    addressLabel.textAlignment = .center
    addressLabel.textColor = .tezosBlue

    self.addressLabel = addressLabel
    self.contractAddressLabel = contractAddressLabel
    self.getTotalBalanceTezButton = UIButton.button(with: "Get Total Balance In Tez")
    self.getTotalBalanceTokensButton = UIButton.button(with: "Get Total Balance in Tokens")
    self.getTotalLiquidityButton = UIButton.button(with: "Get Total Liquidity")
    self.addLiquidityButton = UIButton.button(with: "Add Liquidity")
    self.withdrawLiquidityButton = UIButton.button(with: "Withdraw Liquidity")
    self.buyTezButton = UIButton.button(with: "Buy Tez")
    self.buyTokensButton = UIButton.button(with: "Buy Tokens")

    stackView.frame = UIScreen.main.bounds
    stackView.addArrangedSubview(contractAddressLabel)
    stackView.addArrangedSubview(addressLabel)
    stackView.addArrangedSubview(getTotalBalanceTezButton)
    stackView.addArrangedSubview(getTotalBalanceTokensButton)
    stackView.addArrangedSubview(getTotalLiquidityButton)
    stackView.addArrangedSubview(addLiquidityButton)
    stackView.addArrangedSubview(withdrawLiquidityButton)
    stackView.addArrangedSubview(buyTezButton)
    stackView.addArrangedSubview(buyTokensButton)

    self.stackView = stackView

    super.init(frame: CGRect.zero)

    self.getTotalBalanceTezButton.addTarget(self, action: #selector(getTotalBalanceTezPressed), for: .touchUpInside)
    self.getTotalBalanceTokensButton.addTarget(self, action: #selector(getTotalBalanceTokensPressed), for: .touchUpInside)
    self.getTotalLiquidityButton.addTarget(self, action: #selector(getTotalLiquidityPressed), for: .touchUpInside)
    self.addLiquidityButton.addTarget(self, action: #selector(addLiquidityPressed), for: .touchUpInside)
    self.withdrawLiquidityButton.addTarget(self, action: #selector(withdrawLiquidityPressed), for: .touchUpInside)
    self.buyTezButton.addTarget(self, action: #selector(buyTezPressed), for: .touchUpInside)
    self.buyTokensButton.addTarget(self, action: #selector(buyTokensPressed), for: .touchUpInside)

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
  private func getTotalBalanceTezPressed() {
    self.delegate?.exchangeClientViewDidRequestTotalBalanceTez(self)
  }

  @objc
  private func getTotalBalanceTokensPressed() {
    self.delegate?.exchangeClientViewDidRequestTotalBalanceTokens(self)
  }

  @objc
  private func getTotalLiquidityPressed() {
    self.delegate?.exchangeClientViewDidRequestTotalLiquidity(self)
  }

  @objc
  private func addLiquidityPressed() {
    self.delegate?.exchangeClientViewDidRequestAddLiquidity(self)
  }

  @objc
  private func withdrawLiquidityPressed() {
    self.delegate?.exchangeClientViewDidRequestWithdrawLiquidity(self)
  }

  @objc
  private func buyTezPressed() {
    self.delegate?.exchangeClientViewDidRequestBuyTez(self)
  }

  @objc
  private func buyTokensPressed() {
    self.delegate?.exchangeClientViewDidRequestBuyTokens(self)
  }
}
