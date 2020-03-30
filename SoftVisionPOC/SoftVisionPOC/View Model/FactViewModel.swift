//
//  FactViewModel.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import Foundation

class FactViewModel: NSObject {
    var title:String?
    var factList:[FactDetailResponseModel]?

    init(factList:FactResponseModel) {
        self.title = factList.title ?? ""
        self.factList = factList.rows?.filter({ (item) -> Bool in
            if item.description == nil && item.imageHref == nil && item.title == nil {
                return false
            }
            return true
        })
    }
}
