//
//  ServiceListViewController.swift
//  MyHomeApp
//
//  Created by TRAING Serey on 15/11/2018.
//  Copyright © 2018 AlkRox. All rights reserved.
//

import UIKit
import HomeKit

class ServiceListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedAccessory: HMAccessory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.selectedAccessory.name
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
}

extension ServiceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characViewController = CharacteristicListViewController()
        characViewController.selectedService = self.selectedAccessory.services[indexPath.row]
        self.navigationController?.pushViewController(characViewController, animated: true)
    }
}

extension ServiceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedAccessory.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = self.selectedAccessory.services[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(service.name) -- \(service.serviceType)"
        return cell
    }
}

