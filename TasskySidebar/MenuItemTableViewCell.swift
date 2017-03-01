//
//  MenuItemTableViewCell.swift
//  TasskySidebar
//
//  Created by towry on 01/03/2017.
//  Copyright © 2017 towry. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    func configItem(_ menuItem: Dictionary<String, Any>) {
        self.textLabel?.text = menuItem["text"] as? String
        self.backgroundColor = menuItem["color"] as! UIColor?
    }
}
