//
//  UIViewController+Addition.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {

  func showAlert(mesage: String, title: String? = "", action:(() -> Void)? = nil) {
    UIAlertController.showAlert(mesage: mesage, title: title, view: self, action: action)
  }

  func showActivityIndicator() {
    SVProgressHUD.show()
  }

  func hideActivityIndicator() {
    SVProgressHUD.dismiss()
  }

}
