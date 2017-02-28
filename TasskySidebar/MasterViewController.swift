//
//  MasterViewController.swift
//  TasskySidebar
//
//  Created by towry on 27/02/2017.
//  Copyright © 2017 towry. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        let v1 = UIView()
        v1.backgroundColor = .cyan
        self.view.addSubview(v1)
        
        v1.translatesAutoresizingMaskIntoConstraints = false
        
        // left
        self.view.addConstraint(NSLayoutConstraint(item: v1, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 20.0))
        // right
        self.view.addConstraint(NSLayoutConstraint(item: v1, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -20.0))
        // bottom
        self.view.addConstraint(NSLayoutConstraint(item: v1, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 20.0))
        
        // height
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 20.0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
