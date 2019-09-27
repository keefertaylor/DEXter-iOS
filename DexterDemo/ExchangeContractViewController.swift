// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

class ExchangeContractViewController: UIViewController {
  private let tezosNodeClient: TezosNodeClient
  private let exchangeContractClient: DexterExchangeClient
  private let exchangeContractView: ExchangeContractView
  private let wallet: Wallet

  private let liquidityAdjustAmount = Tez("1")!
  private let deadline = Date().addingTimeInterval(24 * 60 * 60) // 24 hours in the future

  public init(tezosNodeClient: TezosNodeClient, exchangeContractAddress: Address, wallet: Wallet) {
    self.tezosNodeClient = tezosNodeClient
    self.wallet = wallet
    self.exchangeContractClient = DexterExchangeClient(
      exchangeContractAddress: exchangeContractAddress,
      tezosNodeClient: tezosNodeClient
    )
    self.exchangeContractView = ExchangeContractView(
      exchangeContractAddress: exchangeContractAddress,
      walletAddress: wallet.address
    )

    super.init(nibName: nil, bundle: nil)

    self.exchangeContractView.delegate = self
  }

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    fatalError()
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  public override func loadView() {
    self.view = exchangeContractView

    self.navigationItem.title = "DEXter Exchange Contract"
  }
}

// MARK: - ExchangeContractViewDelegate

extension ExchangeContractViewController: ExchangeContractViewDelegate {
  func exchangeClientViewDidRequestTotalBalanceTez(_ exchangeClientView: ExchangeContractView) {
    self.exchangeContractClient.getExchangeBalanceTez() { result in
      switch result {
      case .success(let balance):
        self.showSimpleAlert(title: "Balance", message: "Tez: \(balance)")
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }

  func exchangeClientViewDidRequestTotalBalanceTokens(_ exchangeClientView: ExchangeContractView) {
    // TODO(keefertaylor): If exchanges are mapped 1:1 with token contracts this should be a static prop.
    self.exchangeContractClient.getExchangeBalanceTokens(tokenContractAddress: .tokenContract) { result in
      switch result {
      case .success(let balance):
        self.showSimpleAlert(title: "Balance", message: "Tokens: \(balance)")
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }

  func exchangeClientViewDidRequestTotalLiquidity(_ exchangeClientView: ExchangeContractView) {
    self.exchangeContractClient.getExchangeLiquidity() { result in
      switch result {
      case .success(let liquidity):
        self.showSimpleAlert(title: "Liquidity", message: "Tokens: \(liquidity)")
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }

  func exchangeClientViewDidRequestAddLiquidity(_ exchangeClientView: ExchangeContractView) {
    self.exchangeContractClient.addLiquidity(
      from: wallet.address,
      amount: Tez(10.0),
      signatureProvider: wallet,
      minLiquidity: 1,
      maxTokensDeposited: 1,
      deadline: deadline
    ) { result in
      switch result {
      case .success(let hash):
        self.showHashAlert(hash: hash)
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }

  func exchangeClientViewDidRequestWithdrawLiquidity(_ exchangeClientView: ExchangeContractView) {
    self.exchangeContractClient.withdrawLiquidity(
      from: wallet.address,
      signatureProvider: wallet,
      liquidityBurned: 1,
      tezToWidthdraw: liquidityAdjustAmount,
      minTokensToWithdraw: 1,
      deadline: deadline
    ) { result in
      switch result {
      case .success(let hash):
        self.showHashAlert(hash: hash)
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }

  func exchangeClientViewDidRequestBuyTez(_ exchangeClientView: ExchangeContractView) {
    self.exchangeContractClient.tradeTokenForTez(
      source: wallet.address,
      signatureProvider: wallet,
      tokensToSell: 1,
      minTezToBuy: liquidityAdjustAmount,
      deadline: deadline
    ) { result in
      switch result {
      case .success(let hash):
        self.showHashAlert(hash: hash)
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }

  func exchangeClientViewDidRequestBuyTokens(_ exchangeClientView: ExchangeContractView) {
    self.exchangeContractClient.tradeTezForToken(
      source: wallet.address,
      amount: Tez(1.0),
      signatureProvider: wallet,
      minTokensToPurchase: 1,
      deadline: deadline
    ) { result in
      switch result {
      case .success(let hash):
        self.showHashAlert(hash: hash)
      case .failure(let error):
        self.showError(error: "\(error)")
      }
    }
  }
}
