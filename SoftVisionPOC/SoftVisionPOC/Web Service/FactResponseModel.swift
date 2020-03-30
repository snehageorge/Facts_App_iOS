//
//  FactResponseModel.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class FactResponseModel: Decodable {
    var title: String?
    var rows:[FactDetailResponseModel]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
}

class FactDetailResponseModel: Decodable {
    var title: String?
    var description: String?
    var imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }

}
