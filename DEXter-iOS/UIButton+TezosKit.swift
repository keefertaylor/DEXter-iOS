import UIKit

extension UIButton {
  public static func button(with title: String) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.backgroundColor = .tezosBlue
    button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    button.layer.cornerRadius = 5.0
    button.sizeToFit()

    return button
  }
}
