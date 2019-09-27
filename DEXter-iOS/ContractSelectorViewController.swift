// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

class ContractSelectorViewController: UIViewController {
  private let contractSelectorView: ContractSelectorView

  private let tokenContractViewController: TokenContractViewController
  private let exchangeContractViewController: ExchangeContractViewController

  public init(
    tokenContractViewController: TokenContractViewController,
    exchangeContractViewController: ExchangeContractViewController
  ) {
    self.contractSelectorView = ContractSelectorView()

    self.tokenContractViewController = tokenContractViewController
    self.exchangeContractViewController = exchangeContractViewController

    super.init(nibName: nil, bundle: nil)

    contractSelectorView.delegate = self
  }

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    fatalError()
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  public override func loadView() {
    self.view = contractSelectorView

    self.navigationItem.title = "Select Contract For Interaction"
  }
}

// MARK: - ContractSelectorViewDelegate

extension ContractSelectorViewController: ContractSelectorViewDelegate {
  public func contractSelectorViewRequestedOpenTokenContract(_ contractSelectorView: ContractSelectorView) {
    self.navigationController?.pushViewController(tokenContractViewController, animated: true)
  }

  public func contractSelectorViewRequestedOpenExchangeContract(_ contractSelectorView: ContractSelectorView) {
    self.navigationController?.pushViewController(exchangeContractViewController, animated: true)
  }
}