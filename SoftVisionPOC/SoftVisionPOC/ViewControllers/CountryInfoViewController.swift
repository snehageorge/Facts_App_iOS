//
//  CountryInfoViewController.swift
//  SoftVisionPOC
//
//  Created by Sneha G on 30/03/20.
//  Copyright © 2020 QBurst. All rights reserved.
//

import UIKit

class CountryInfoViewController: BaseViewController {
    
    var tableView:UITableView?
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .white
        
        tableView = UITableView()
        view.addSubview(tableView!)
        tableView?.translatesAutoresizingMaskIntoConstraints =  false
        tableView?.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: CountryInfoTableViewCell.cellId)
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
        APIManager.countryInfoAPI()
    }
}

extension CountryInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryInfoTableViewCell.cellId, for: indexPath) as! CountryInfoTableViewCell
        return cell
    }
}


