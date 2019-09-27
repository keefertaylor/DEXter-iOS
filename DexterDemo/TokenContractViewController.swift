// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

class TokenContractViewController: UIViewController {
  private let transferTargetAddress: Address = "tz1XarY7qEahQBipuuNZ4vPw9MN6Ldyxv8G3"
  private let transferTargetAmount: Int = 1

  private let tezosNodeClient: TezosNodeClient
  private let tokenContractClient: TokenContractClient
  private let tokenContractView: TokenContractView
  private let wallet: Wallet

  public init(tezosNodeClient: TezosNodeClient, tokenContractAddress: Address, wallet: Wallet) {
    self.tezosNodeClient = tezosNodeClient
    self.wallet = wallet
    self.tokenContractClient = TokenContractClient(
      tokenContractAddress: tokenContractAddress,
      tezosNodeClient: tezosNodeClient
    )
    tokenContractView = TokenContractView(
      tokenContractAddress: tokenContractAddress,
      walletAddress: wallet.address
    )

    super.init(nibName: nil, bundle: nil)

    tokenContractView.delegate = self
  }

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    fatalError()
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  public override func loadView() {
    self.view = tokenContractView

    self.navigationItem.title = "Token Contract"
  }

  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )

    let dismissAction = UIAlertAction(
      title: "Got it!",
      style: .default
    )
    alert.addAction(dismissAction);
    self.present(alert, animated: true, completion: nil)
  }

  /// Show a generic error.
  private func showError() {
    self.showAlert(title: "Error", message: "Try again later.")
  }
}

// MARK: - TokenContractViewDelegate

extension TokenContractViewController: TokenContractViewDelegate {
  public func tokenContractViewDidRequestBalance(_ tokenContractView: TokenContractView) {
    self.tokenContractClient.getTokenBalance(address: wallet.address) { result in
      switch result {
      case .success(let balance):
        print("balance: \(balance)")
      case .failure(let error):
        print("error: \(error)")
      }
    }
  }

  public func tokenContractViewDidRequestTokenTransfer(_ tokenContractView: TokenContractView) {
    self.tokenContractClient.transferTokens(
      from: wallet.address,
      to: transferTargetAddress,
      numTokens: transferTargetAmount,
      signatureProvider: wallet
    ) { result in
      switch result {
      case .success(let hash):
        print("Transfered with hash: \(hash)")
      case .failure(let error):
        print("error: \(error)")
      }
    }
  }
}
