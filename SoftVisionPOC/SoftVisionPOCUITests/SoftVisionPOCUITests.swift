//
//  SoftVisionPOCUITests.swift
//  SoftVisionPOCUITests
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import XCTest

class SoftVisionPOCUITests: XCTestCase {

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  override func tearDownWithError() throws {
  }

  /// Test existence of cell
  func testTableViewController() {
    let app = XCUIApplication()
    app.launch()

    let factsTableView = app.tables.matching(identifier: "tableView")
    let firstCell = factsTableView.cells.element(matching: .cell, identifier: "tableView 0 0")
    let existencePredicate = NSPredicate(format: "exists == 1")
    let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
    let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 15.0)
    XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
  }

  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
