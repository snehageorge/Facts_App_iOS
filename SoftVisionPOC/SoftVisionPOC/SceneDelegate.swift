//
//  SceneDelegate.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  @available(iOS 13.0, *)
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    self.window = UIWindow(windowScene: windowScene)
    self.window?.rootViewController = UINavigationController(rootViewController: FactsViewController())
    self.window?.makeKeyAndVisible()
  }

  @available(iOS 13.0, *)
  func sceneDidDisconnect(_ scene: UIScene) {
  }

  @available(iOS 13.0, *)
  func sceneDidBecomeActive(_ scene: UIScene) {
  }

  @available(iOS 13.0, *)
  func sceneWillResignActive(_ scene: UIScene) {
  }

  @available(iOS 13.0, *)
  func sceneWillEnterForeground(_ scene: UIScene) {
  }

  @available(iOS 13.0, *)
  func sceneDidEnterBackground(_ scene: UIScene) {
  }

}
