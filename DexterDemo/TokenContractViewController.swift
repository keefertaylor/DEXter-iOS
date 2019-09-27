// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

class TokenContractViewController: UIViewController {
  private let tezosNodeClient: TezosNodeClient
  private let tokenContractClient: TokenContractClient
  private let tokenContractView: TokenContractView

  public init(tezosNodeClient: TezosNodeClient, tokenContractAddress: Address) {
    self.tezosNodeClient = tezosNodeClient
    self.tokenContractClient = TokenContractClient(
      tokenContractAddress: tokenContractAddress,
      tezosNodeClient: tezosNodeClient
    )
    tokenContractView = TokenContractView(tokenContractAddress: tokenContractAddress)

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
}
