import UIKit

extension UIViewController {
  /// Show an alert to the user.
  internal func showSimpleAlert(title: String, message: String) {
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

  internal func showHashAlert(hash: String) {
    let alert = UIAlertController(
      title: "Injected Operation",
      message: "Operation successfully injected with hash: \(hash)",
      preferredStyle: .alert
    )

    let blockExplorerAction = UIAlertAction(title: "Open Block Explorer", style: .default) { _ in
      let url = URL(string: "http://alphanet.tzscan.io/\(hash)")!
      UIApplication.shared.open(url)
    }
    alert.addAction(blockExplorerAction)

    let dismissAction = UIAlertAction(
      title: "Got it!",
      style: .default
    )
    alert.addAction(dismissAction);


    self.present(alert, animated: true, completion: nil)
  }

  /// Show a generic error.
  internal func showError(error: String) {
    self.showSimpleAlert(title: "Error", message: error)
  }
}
