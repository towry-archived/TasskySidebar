//
// Created by towry on 28/02/2017.
// Copyright (c) 2017 towry. All rights reserved.
//

import UIKit

class DetailViewController: UIKit.UIViewController {

    var menuButton: MenuButtonView?
    weak var delegate: SidebarAnimationDelegate?
    weak var masterView: MasterViewController?

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.navigationController?.navigationBar.barTintColor = .black
        self.menuButton = MenuButtonView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let tapMenuGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(menuButtonTapped))
        menuButton?.addGestureRecognizer(tapMenuGestureRecognizer)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton!)

        let navCtl = self.parent as? UINavigationController
        self.masterView = navCtl?.parent as? MasterViewController
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
}
