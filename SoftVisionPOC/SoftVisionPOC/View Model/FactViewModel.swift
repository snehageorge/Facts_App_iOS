//
//  FactViewModel.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import Foundation

class FactViewModel: NSObject {
  var title: String?
  var factList: [FactDetailResponseModel]?

  /// Clean up fact list from the API response. Filter out the empty fact contents from the API response
  /// - Parameter factList: Fact API response
  init(factList: FactResponseModel) {
    self.title = factList.title ?? ""
    self.factList = factList.rows?.filter({ (item) -> Bool in
      /// if the description, title and image is empty, remove it from the the list that feeds to the UITableView
      if item.title == nil {
        return false
      }
      return true
    })
  }
}
