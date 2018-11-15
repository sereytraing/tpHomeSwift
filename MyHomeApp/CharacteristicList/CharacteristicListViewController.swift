//
//  CharacteristicListViewController.swift
//  MyHomeApp
//
//  Created by TRAING Serey on 15/11/2018.
//  Copyright © 2018 AlkRox. All rights reserved.
//

import UIKit
import HomeKit

class CharacteristicListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedService: HMService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.selectedService.name
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension CharacteristicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let charac = self.selectedService.characteristics[indexPath.row]
        if var value = charac.value as? Int {
            value = value == 0 ? 1 : 0
            charac.writeValue(value) {
                err in
                print(err)
            }
        }
    }
}

extension CharacteristicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedService.characteristics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let charac = self.selectedService.characteristics[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if  charac.characteristicType == HMCharacteristicTypeName {
            cell.textLabel?.text = "Name \(charac.value)"
        }
        
        if  charac.characteristicType == HMCharacteristicTypePowerState {
            cell.textLabel?.text = "Power state \(charac.value)"
        }
        
        if  charac.characteristicType == HMCharacteristicTypeOutletInUse {
            cell.textLabel?.text = "In use \(charac.value)"
        }
        
        
        
        
        return cell
    }
}
