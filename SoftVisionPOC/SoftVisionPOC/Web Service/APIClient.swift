//
//  APIClient.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

enum DataError: Error {
  case invalidData
  case decodingError
  case serverError
}

typealias result<T> = (Result<T, Error>) -> Void

final class APIClient: NSObject {

  static let sharedInstance = APIClient()

  func callRequest<T: Decodable>(request clientRequest: BaseRequestModel,
                                 of type: T.Type,
                                 completion: @escaping result<T>) {

    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.timeoutIntervalForRequest = 20.0
    let session = URLSession(configuration: sessionConfiguration)
    var request = URLRequest(url: clientRequest.requestUrl())
    request.httpMethod = clientRequest.requestMethod()
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      if error != nil {
        DispatchQueue.main.async {
          completion(.failure(error!))
        }
      }
      ///HTTP response status code from 200 to 299 is considered as succes
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
          DispatchQueue.main.async {
            completion(.failure(DataError.serverError))
          }
          return
      }

      let charSetCode = Constant.characterSet
      let charSetEncoded = CFStringConvertIANACharSetNameToEncoding(charSetCode as CFString)
      let charSetStringEncoded = CFStringConvertEncodingToNSStringEncoding(charSetEncoded)

      if  let jsonString = String(data: data!, encoding: String.Encoding(rawValue: charSetStringEncoded)) {
        let objectData = jsonString.data(using: String.Encoding.utf8)
        do {
          let decodedData: T = try JSONDecoder().decode(T.self, from: objectData!)
          DispatchQueue.main.async {
            completion(.success(decodedData))
          }
        } catch {
          DispatchQueue.main.async {
            completion(.failure(DataError.decodingError))
          }
        }
      } else {
        DispatchQueue.main.async {
          completion(.failure(DataError.invalidData))
        }
      }
    })
    task.resume()
  }
}
