//
//  APIClient.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

final class APIClient: NSObject {

    static let sharedInstance = APIClient()

    func callRequest() {

        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 20.0
        let session = URLSession(configuration: sessionConfiguration)
        let task = session.dataTask(with:URL(string: Base.url)! , completionHandler: { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(error?.localizedDescription ?? "Error")
                    return
            }

            let charSetCode = Constant.characterSet
            let charSetEncoded = CFStringConvertIANACharSetNameToEncoding(charSetCode as CFString)
            let charSetStringEncoded = CFStringConvertEncodingToNSStringEncoding(charSetEncoded)

            if  let jsonString = String(data: data!, encoding: String.Encoding(rawValue: charSetStringEncoded)) {
                print(jsonString)
                let objectData = jsonString.data(using: String.Encoding.utf8)
                do {
                    //let decodedData: T = try JSONDecoder().decode(T.self, from: objectData!)
                    let respDict = try JSONSerialization.jsonObject(with: objectData!, options: []) as? [String: Any]
                    print("Success")
                } catch {
                    // Handle error
                    print(error)
                    print("decoding error")
                }
            }else {
                print("Invalid data")
            }
        })
        task.resume()
    }
}
