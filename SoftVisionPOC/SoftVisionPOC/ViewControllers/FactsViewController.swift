//
//  FactsViewController.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class FactsViewController: BaseViewController {

  var factTableView: UITableView?
  var factViewModel: FactViewModel? {
    didSet {
      self.title = factViewModel?.title
      factTableView?.reloadData()
    }
  }
  let refreshControl = UIRefreshControl()

  override func loadView() {
    self.view = UIView()
    view.backgroundColor = .white

    // Setup TableView and cells
    factTableView = UITableView()
    view.addSubview(factTableView!)
    factTableView?.translatesAutoresizingMaskIntoConstraints =  false
    factTableView?.register(FactTableViewCell.self, forCellReuseIdentifier: CellIdentifier.Fact)
    factTableView?.allowsSelection = false
    factTableView?.delegate = self
    factTableView?.dataSource = self
    factTableView?.isAccessibilityElement = true
    factTableView?.accessibilityIdentifier = "tableView"
    // align tableView from the left and right
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": factTableView!]))

    // align tableView from the top and bottom
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": factTableView!]))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUIComponents()
    factListAPICall(refresh: false)
  }

  func setupUIComponents() {
    factTableView?.estimatedRowHeight = Constant.factCellEstimatedHeight
    factTableView?.rowHeight = UITableView.automaticDimension
    refreshControl.addTarget(self, action: #selector(factListAPICall), for: .valueChanged)
    factTableView?.addSubview(refreshControl)
  }

  /// API call to get the fact list
  /// - Parameter refresh: If this API call is generated as a result of pull to refresh action or not. If refresh Bool is true no activity indicator will be displayed during the API call.

  @objc func factListAPICall(refresh: Bool = true) {
    if !refresh {
      showActivityIndicator()
    }
    APIManager.factAPI(successBlock: { [weak self] (listViewModel) in
      guard let self = self else { return }
      self.factViewModel = listViewModel
      self.stopUINetworkActivites(refresh: refresh)
      }, failureBlock: { [weak self] (errMsg) in
        guard let self = self else { return }
        self.stopUINetworkActivites(refresh: refresh)
        self.showAlert(mesage: errMsg)
    })
  }

  func stopUINetworkActivites(refresh: Bool) {
    self.refreshControl.endRefreshing()
    if !refresh {
      hideActivityIndicator()
    }
  }
}

extension FactsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return factViewModel?.factList?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.Fact, for: indexPath) as! FactTableViewCell
    if let rows = factViewModel?.factList {
      let item: FactDetailResponseModel = rows[indexPath.row]
      cell.item = item
    }
    cell.isAccessibilityElement = true
    cell.accessibilityIdentifier = "tableView \(indexPath.section) \(indexPath.row)"
    return cell
  }
}
