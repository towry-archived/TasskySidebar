//
//  MasterViewController.swift
//  TasskySidebar
//
//  Created by towry on 27/02/2017.
//  Copyright © 2017 towry. All rights reserved.
//

import UIKit

let kMenubarWidth = 80

class MasterViewController: UIViewController {

    var scrollView: UIScrollView?
    var subRootViews: [UINavigationController]?
    var contentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue

        self.scrollView = UIScrollView()
        self.scrollView?.translatesAutoresizingMaskIntoConstraints = false
        if let scrollView = self.scrollView {
            self.view.addSubview(scrollView)
            scrollView.backgroundColor = .white
            scrollView.clipsToBounds = true
            scrollView.delegate = self

            // Add constraints to scroll view upon it's superview.
            self.addConstraintsToScrollView()
            // Add scrollview's contents.
            self.addScrollViewSubViews()
        }
    }

    func addConstraintsToScrollView() {
        let view = self.scrollView!
        self.view.addConstraints([

                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        ])
    }

    func addScrollViewSubViews() {
        let sv = self.scrollView!

        // Add a view to manage the contents.
        self.contentView = UIView(frame: CGRect(x: 0, y:0, width: 600 + kMenubarWidth, height: 600))
        contentView?.frame = sv.bounds
        sv.addSubview(self.contentView!)
        self.addConstraintsToContentView()

        // Add a menu container view
        let menuContainerView = UIView(frame: CGRect(x: 0, y: 0, width: kMenubarWidth, height: 600))
        // Add a detail container view
        let detailContainerView = UIView(frame: CGRect(x: kMenubarWidth, y: 0, width: 600, height: 600))


        let detailViewCtl = DetailViewController()
        let menubarViewCtl = MenubarViewController()

        let leftNav = UINavigationController(rootViewController: menubarViewCtl)
        let rightNav = UINavigationController(rootViewController: detailViewCtl)

        self.addChildViewController(leftNav)
        self.view.addSubview(leftNav.view)
        leftNav.didMove(toParentViewController: self)

        self.addChildViewController(rightNav)
        self.view.addSubview(rightNav.view)
        rightNav.didMove(toParentViewController: rightNav)

        leftNav.navigationBar.isTranslucent = false
        rightNav.navigationBar.isTranslucent = false
    }

    func addConstraintsToContentView() {
        let view = self.contentView!
        let sv = self.scrollView!

        // Add constraints to content view between the scrollview
        sv.addConstraints([

            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: sv, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: sv, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: sv, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: sv, attribute: .bottom, multiplier: 1.0, constant: 0),
        ])

        // Add height and width constraints to content view between the superview of scrollview.
        // because the superview of scrollview(self.view) has a fixed width and height.
        // and scrollview can scroll, the it's width and height is not same as superview's.

        self.view.addConstraints([
            // width constraint
            // the constant is 80, because we want to the content view wider than the superview of scrollview,
            // so it can accommodate the menu view.
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: kMenubarWidth),
            // height constraint
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0)
        ])
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension  MasterViewController: UIScrollViewDelegate {

}