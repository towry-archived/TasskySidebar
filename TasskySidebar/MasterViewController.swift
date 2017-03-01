//
//  MasterViewController.swift
//  TasskySidebar
//
//  Created by towry on 27/02/2017.
//  Copyright © 2017 towry. All rights reserved.
//

import UIKit

let kMenubarWidth: CGFloat = 80.0

class MasterViewController: UIViewController {

    var scrollView: UIScrollView?
    var contentView: UIView?
    var detailViewCtl: DetailViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue

        self.scrollView = UIScrollView()
        self.scrollView?.isPagingEnabled = (scrollView?.contentOffset.x)! < ((scrollView?.contentSize.width)! - (scrollView?.frame.width)!)
        self.scrollView?.bounces = false
        self.scrollView?.translatesAutoresizingMaskIntoConstraints = false
        if let scrollView = self.scrollView {
            self.view.addSubview(scrollView)
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.backgroundColor = .white
            scrollView.clipsToBounds = true
            scrollView.delegate = self

            // Add constraints to scroll view upon it's superview.
            self.addConstraintsToScrollView()
            // Add scrollview's contents.
            self.addScrollViewSubViews()
        }
        
        self.automaticallyAdjustsScrollViewInsets = false
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
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        sv.addSubview(self.contentView!)
        self.addConstraintsToContentView()

        // Add a menu container view
        let menuContainerView = UIView(frame: CGRect(x: 0, y: 0, width: kMenubarWidth, height: 600))
        menuContainerView.translatesAutoresizingMaskIntoConstraints = false
        menuContainerView.backgroundColor = .red
        // Add a detail container view
        let detailContainerView = UIView(frame: CGRect(x: kMenubarWidth, y: 0, width: 600, height: 600))
        detailContainerView.translatesAutoresizingMaskIntoConstraints = false
        detailContainerView.backgroundColor = .blue
        contentView?.addSubview(menuContainerView)
        contentView?.addSubview(detailContainerView)
        
        // - add constraints for menuContainerView and detailContainerView
        contentView?.addConstraints([
            NSLayoutConstraint(item: menuContainerView, attribute: .top, relatedBy: .equal, toItem: contentView!, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: menuContainerView, attribute: .bottom, relatedBy: .equal, toItem: contentView!, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: menuContainerView, attribute: .leading, relatedBy: .equal, toItem: contentView!, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: menuContainerView, attribute: .trailing, relatedBy: .equal, toItem: detailContainerView, attribute: .leading, multiplier: 1.0, constant: 0),
            ])
        menuContainerView.addConstraint(NSLayoutConstraint(item: menuContainerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: kMenubarWidth))
        
        contentView?.addConstraints([
            NSLayoutConstraint(item: detailContainerView, attribute: .top, relatedBy: .equal, toItem: contentView!, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: detailContainerView, attribute: .bottom, relatedBy: .equal, toItem: contentView!, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: detailContainerView, attribute: .trailing, relatedBy: .equal, toItem: contentView!, attribute: .trailing, multiplier: 1.0, constant: 0)
            ])
        
        // - end

        
        let menubarViewCtl = MenubarViewController()
        let detailViewCtl = DetailViewController()
        self.detailViewCtl = detailViewCtl

        let leftNav = UINavigationController(rootViewController: menubarViewCtl)
        let rightNav = UINavigationController(rootViewController: detailViewCtl)

        self.addChildViewController(leftNav)
        menuContainerView.addSubview(leftNav.view)
        leftNav.view.frame = menuContainerView.bounds
        leftNav.view.autoresizesSubviews = true
        leftNav.view.translatesAutoresizingMaskIntoConstraints = true
        // constraint
        menuContainerView.addConstraints([
            NSLayoutConstraint(item: leftNav.view, attribute: .top, relatedBy: .equal, toItem: menuContainerView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: leftNav.view, attribute: .bottom, relatedBy: .equal, toItem: menuContainerView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: leftNav.view, attribute: .leading, relatedBy: .equal, toItem: menuContainerView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: leftNav.view, attribute: .trailing, relatedBy: .equal, toItem: menuContainerView, attribute: .trailing, multiplier: 1.0, constant: 0),
        ])
        leftNav.didMove(toParentViewController: self)

        self.addChildViewController(rightNav)
        detailContainerView.addSubview(rightNav.view)
        rightNav.view.frame = detailContainerView.bounds
        rightNav.view.translatesAutoresizingMaskIntoConstraints = true
        // constraint

        rightNav.didMove(toParentViewController: self)

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
