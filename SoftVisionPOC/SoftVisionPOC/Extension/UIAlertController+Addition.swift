//
//  UIAlertController+Addition.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

extension UIAlertController {

  class func showAlert(mesage: String,
                       title: String? = "",
                       view: UIViewController?,
                       action:(() -> Void)? = nil) {

    let alert = UIAlertController(title: title, message: mesage, preferredStyle: UIAlertController.Style.alert)
    let okAlert = NSLocalizedString("OK".localized, comment: "")
    alert.addAction(UIAlertAction(title: okAlert, style: UIAlertAction.Style.cancel, handler: { (_) in
      action?()
    }))

    if let view = view {
      view.present(alert, animated: true, completion: nil)
    } else {
      Constant.appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
  }
}
