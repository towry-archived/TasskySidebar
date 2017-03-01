//
// Created by towry on 28/02/2017.
// Copyright (c) 2017 towry. All rights reserved.
//

import UIKit

typealias MenuItemType = Dictionary<String, Any>

let kMenuItemCount = 7

class MenubarViewController: UIViewController {
    
    var tableView: UITableView?
    weak var delegate: SidebarAnimationDelegate?
    
    lazy var menuItems: [MenuItemType] = {
        var dic = [MenuItemType]()
        
        for i in 1...7 {
            dic.append(["text": "m\(i)", "color": UIColor.randomColor()])
        }
        
        return dic
    }()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        self.navigationController?.view.clipsToBounds = true
        
        self.setupTable()
        
        self.delegate?.didSelect(self.menuItems[0])
    }
    
    func setupTable() {
        let tv = UITableView(frame: self.view.bounds)
        tv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tv.backgroundColor = UIColor.black
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        self.tableView = tv
        self.view.addSubview(tv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MenubarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(self.menuItems[indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kMenuItemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? MenuItemTableViewCell
        if cell == nil {
            cell = MenuItemTableViewCell(style: .default, reuseIdentifier: "cellId")
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = .white
            cell?.selectionStyle = .none
        }
        
        let menuItem = self.menuItems[indexPath.row] 
        cell?.configItem(menuItem)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(80, self.view.bounds.height / CGFloat(kMenuItemCount))
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
