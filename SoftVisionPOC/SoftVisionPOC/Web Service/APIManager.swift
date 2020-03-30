//
//  APIManager.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    class func factAPI(successBlock:((_ resp:FactViewModel) -> Void)?, failureBlock: ((_ errMsg:String) -> Void)?) {
        APIClient.sharedInstance.callRequest(request: FactRequestModel(), of: FactResponseModel.self) { (result) in
            switch result {

            case .failure(let error):
                failureBlock?(error.localizedDescription)

            case .success(let facts):
                let itemViewModel = FactViewModel(factList: facts)
                successBlock?(itemViewModel)
            }
        }
    }
}
