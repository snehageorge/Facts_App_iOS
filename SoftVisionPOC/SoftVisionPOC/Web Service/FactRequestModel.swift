//
//  FactRequestModel.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class FactRequestModel: BaseRequestModel {

  override func requestUrl() -> URL {
    if let url = URL(string: Base.url) {
      return url
    } else {
      fatalError("Invalid Url")
    }
  }

}
