//
//  AccessoryBrowserViewController.swift
//  MyHomeApp
//
//  Created by TRAING Serey on 15/11/2018.
//  Copyright © 2018 AlkRox. All rights reserved.
//

import UIKit
import HomeKit

class AccessoryBrowserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedHome: HMHome!
    var accessoryBrowser: HMAccessoryBrowser!
    var accessories: [HMAccessory] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Searching..."
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.accessoryBrowser = HMAccessoryBrowser()
        self.accessoryBrowser.delegate = self
        self.accessoryBrowser.startSearchingForNewAccessories()
    }
}

extension AccessoryBrowserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.accessories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accessories.count
    }
}

extension AccessoryBrowserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedHome.addAccessory(self.accessories[indexPath.row]) {
            err in
            if err == nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension AccessoryBrowserViewController: HMAccessoryBrowserDelegate {
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        self.accessories.append(accessory)
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        if let index = self.accessories.firstIndex(where: {
            acc -> Bool in
            return acc.uniqueIdentifier == accessory.uniqueIdentifier
        }) {
            self.accessories.remove(at: index)
        }
    }
}
