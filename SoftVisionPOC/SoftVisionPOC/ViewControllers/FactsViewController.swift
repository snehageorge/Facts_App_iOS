//
//  FactsViewController.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class FactsViewController: BaseViewController {

    var tableView:UITableView?
    var itemViewModel:FactViewModel? {
        didSet {
            self.title = itemViewModel?.title
            tableView?.reloadData()
        }
    }
    let refreshControl = UIRefreshControl()

    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .white

        tableView = UITableView()
        view.addSubview(tableView!)
        tableView?.translatesAutoresizingMaskIntoConstraints =  false
        tableView?.register(FactTableViewCell.self, forCellReuseIdentifier: CellIdentifier.Fact)
        tableView?.allowsSelection = false
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isAccessibilityElement = true
        tableView?.accessibilityIdentifier = "tableView"
        // align tableView from the left and right
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": tableView!]));

        // align tableView from the top and bottom
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": tableView!]));

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        itemListAPICall(refresh: false)
    }

    func setupUIComponents() {
        tableView?.estimatedRowHeight = 80
        tableView?.rowHeight = UITableView.automaticDimension
        refreshControl.addTarget(self, action: #selector(itemListAPICall), for: .valueChanged)
        tableView?.addSubview(refreshControl)
    }

    @objc func itemListAPICall(refresh:Bool = true) {
        if !refresh {
            showActivityIndicator()
        }
        APIManager.factAPI(successBlock: { [weak self] (listViewModel) in
            guard let self = self else { return }
            self.itemViewModel = listViewModel
            self.stopUINetworkActivites(refresh:refresh)
            },failureBlock:{ [weak self] (errMsg) in
                guard let self = self else { return }
                self.stopUINetworkActivites(refresh:refresh)
                self.showAlert(mesage: errMsg)
        })
    }

    func stopUINetworkActivites(refresh:Bool) {
        self.refreshControl.endRefreshing()
        if !refresh {
            hideActivityIndicator()
        }
    }
}

extension FactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemViewModel?.factList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.Fact, for: indexPath) as! FactTableViewCell
        if let rows = itemViewModel?.factList {
            let item:FactDetailResponseModel = rows[indexPath.row]
            cell.item = item
        }
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "tableView \(indexPath.section) \(indexPath.row)"
        return cell
    }
}


