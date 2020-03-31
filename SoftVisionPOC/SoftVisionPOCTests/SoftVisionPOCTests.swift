//
//  SoftVisionPOCTests.swift
//  SoftVisionPOCTests
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import XCTest
@testable import SoftVisionPOC

class SoftVisionPOCTests: XCTestCase {
  var factsViewController: FactsViewController?

  override func setUpWithError() throws {
    factsViewController = FactsViewController()
    factsViewController?.loadViewIfNeeded()
  }

  override func tearDownWithError() throws {
    factsViewController = nil
  }

  /// Test the main UI components in the FactsViewController
  func testFactsViewControllerUI() {
    XCTAssertNotNil(factsViewController?.factTableView, "Tableview is missing")
    let refreshControl = factsViewController?.refreshControl
    XCTAssertNotNil(refreshControl, "Refresh control is missing")
    let action = refreshControl?.actions(forTarget: factsViewController, forControlEvent: .valueChanged)
    XCTAssertNotNil(action, "Pull to refresh is not attached to value changed event.")
  }

  /// Mock the response and test the model and viewmodel classes and methods
  func testFactsAPIMockResponse() {
    let testBundle = Bundle(for: type(of: self))
    let path = testBundle.path(forResource: "factResponse", ofType: "json")
    let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    do {
      let decodedData: FactResponseModel = try JSONDecoder().decode(FactResponseModel.self, from: data!)
      XCTAssertTrue(decodedData.title != nil && decodedData.rows != nil, "Invalid response")
      XCTAssertTrue(decodedData.rows?.count == 14, "Invalid number of rows")
      let viewModel = FactViewModel(factList: decodedData)
      XCTAssertTrue(viewModel.factList?.count == 13, "Invalid number of rows")
    } catch {
      XCTFail("Unable to parse the response")
    }
  }

  func testFactsAPICall() {
    let promise = expectation(description: "Status code between 200 and 299")
    APIManager.factAPI(successBlock: { (_) in
      promise.fulfill()
    }, failureBlock: { (errMsg) in
      XCTFail("Error Message: " + errMsg)
    })
    wait(for: [promise], timeout: 20)
  }

  func testPerformanceExample() throws {
    self.measure {
    }
  }

}
