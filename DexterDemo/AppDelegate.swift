// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let tezosNodeClient = TezosNodeClient(remoteNodeURL: URL(string: "https://tezos-dev.cryptonomic-infra.tech:443")!)
  let wallet = Wallet(mnemonic: "predict corn duty process brisk tomato shrimp virtual horror half rhythm cook")!

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds);

    let tokenContractViewController = TokenContractViewController(
      tezosNodeClient: tezosNodeClient,
      tokenContractAddress: .tokenContract,
      wallet: wallet
    )

    let contractSelectorViewController = ContractSelectorViewController(
      tokenContractViewController: tokenContractViewController
    )

    let navController = UINavigationController(rootViewController: contractSelectorViewController)
    navController.navigationBar.barTintColor = .tezosBlue
    navController.navigationBar.tintColor = .white
    let textAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
    navController.navigationBar.titleTextAttributes = textAttributes

    window.rootViewController = navController
    window.makeKeyAndVisible()

    self.window = window

    return true
  }
}
