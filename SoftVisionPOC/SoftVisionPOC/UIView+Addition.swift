//
//  UIView+Addition.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

extension UIView {

    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {

        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)

        let insets = self.safeAreaInsets
        topInset = insets.top
        bottomInset = insets.bottom

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            safeAreaLayoutGuide.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            safeAreaLayoutGuide.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

    }

    func heightGreaterThanOrEqualAnchor(height:CGFloat) {
        if height != 0 {
            heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        }
    }

}
