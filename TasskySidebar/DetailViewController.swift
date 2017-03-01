//
// Created by towry on 28/02/2017.
// Copyright (c) 2017 towry. All rights reserved.
//

import UIKit

class DetailViewController: UIKit.UIViewController {

    var menuButton: MenuButtonView?
    weak var delegate: SidebarAnimationDelegate?
    weak var masterView: MasterViewController?
    var label: UILabel?

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        self.navigationController?.view.clipsToBounds = true

        self.menuButton = MenuButtonView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let tapMenuGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(menuButtonTapped))
        menuButton?.addGestureRecognizer(tapMenuGestureRecognizer)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)

        let navCtl = self.parent as? UINavigationController
        self.masterView = navCtl?.parent as? MasterViewController
        
        // add a label to show the menu text
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 60))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black

        self.label = label
        self.view.addSubview(label)
        
        // constraints for label to align center.
        let width = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        let height = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        let xCenter = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let yCenter = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([xCenter, yCenter, width, height])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func menuButtonTapped() {
        if self.masterView == nil || self.delegate == nil {
            print("master view or delegate is nil")
        } else {
            self.delegate!.showOrHide(!(self.masterView?.isMenuShow)!, animated: true)
        }
    }
    
    func presentDetail(_ item: MenuItemType) {
        self.view.backgroundColor = item["color"] as! UIColor?
        self.label?.text = item["text"] as! String?
    }
}
