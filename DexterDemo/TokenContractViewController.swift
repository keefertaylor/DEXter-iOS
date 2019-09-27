// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

class TokenContractViewController: UIViewController {
  private let tezosNodeClient: TezosNodeClient
  private let tokenContractView: TokenContractView

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    tokenContractView = TokenContractView()
    tezosNodeClient = TezosNodeClient()

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    tokenContractView.delegate = self
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  public override func loadView() {
    self.view = tokenContractView
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
