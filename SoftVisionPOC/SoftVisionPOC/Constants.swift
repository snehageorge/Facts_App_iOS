//
//  Constants.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

enum Base {
  static let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

enum Constant {
  static let appDelegate = UIApplication.shared.delegate as! AppDelegate
  static let characterSet = "iso-8859-1"

  static let factCellEstimatedHeight = CGFloat(80.0)
}

enum CellIdentifier {
  static let Fact = "Fact"
}
