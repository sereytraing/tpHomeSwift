//
//  AccessoryListViewController.swift
//  MyHomeApp
//
//  Created by TRAING Serey on 15/11/2018.
//  Copyright © 2018 AlkRox. All rights reserved.
//

import UIKit
import HomeKit

class AccessoryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedHome: HMHome!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.selectedHome.name
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension AccessoryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedHome.accessories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.selectedHome.accessories[indexPath.row].name
        return cell
    }
}
