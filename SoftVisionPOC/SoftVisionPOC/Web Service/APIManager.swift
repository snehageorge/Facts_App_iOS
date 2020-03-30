//
//  APIManager.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    class func countryInfoAPI() {
        APIClient.sharedInstance.callRequest()
    }

}
