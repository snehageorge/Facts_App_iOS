//
//  BaseRequestModel.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

enum Method:String {
    case get = "GET"
    case post = "POST"
}

class BaseRequestModel: NSObject {

    func requestMethod() -> String {
        return Method.get.rawValue
    }

    func requestUrl() -> URL {
        fatalError("Override requestURL")
    }
}
