// Copyright Keefer Taylor, 2019.
import TezosKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let tezosNodeClient = TezosNodeClient()

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds);

    let tokenContractViewController = TokenContractViewController(
      tezosNodeClient: tezosNodeClient,
      tokenContractAddress: .tokenContract
    )
    let navController = UINavigationController(rootViewController: tokenContractViewController)
    navController.navigationBar.barTintColor = .tezosBlue

    window.rootViewController = navController
    window.makeKeyAndVisible()

    self.window = window

    return true
  }
}
