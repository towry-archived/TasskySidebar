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
    var isMenuShow = false
    var menuContainerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue

        self.scrollView = UIScrollView()
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
        contentView?.backgroundColor = .black
        contentView?.frame = sv.bounds
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        sv.addSubview(self.contentView!)
        self.addConstraintsToContentView()

        // Add a menu container view
        let menuContainerView = UIView(frame: CGRect(x: 0, y: 0, width: kMenubarWidth, height: 600))
        menuContainerView.translatesAutoresizingMaskIntoConstraints = false
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

        self.menuContainerView = menuContainerView
        // - end

        
        let menubarViewCtl = MenubarViewController()
        let detailViewCtl = DetailViewController()
        self.detailViewCtl = detailViewCtl
        self.detailViewCtl?.delegate = self

        let leftNav = UINavigationController(rootViewController: menubarViewCtl)
        let rightNav = UINavigationController(rootViewController: detailViewCtl)

        // - menu
        self.addChildViewController(leftNav)
        menuContainerView.addSubview(leftNav.view)
        leftNav.view.frame = menuContainerView.bounds
        leftNav.view.autoresizesSubviews = true
        leftNav.view.translatesAutoresizingMaskIntoConstraints = true
        // constraint for leftnav's root view
        menuContainerView.addConstraints([
            NSLayoutConstraint(item: leftNav.view, attribute: .top, relatedBy: .equal, toItem: menuContainerView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: leftNav.view, attribute: .bottom, relatedBy: .equal, toItem: menuContainerView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: leftNav.view, attribute: .leading, relatedBy: .equal, toItem: menuContainerView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: leftNav.view, attribute: .trailing, relatedBy: .equal, toItem: menuContainerView, attribute: .trailing, multiplier: 1.0, constant: 0),
        ])
        leftNav.didMove(toParentViewController: self)
        // - end

        // - detail
        self.addChildViewController(rightNav)
        detailContainerView.addSubview(rightNav.view)
        rightNav.view.frame = detailContainerView.bounds
        rightNav.view.translatesAutoresizingMaskIntoConstraints = true
        // constraint for right nav's root view
        detailContainerView.addConstraints([
            NSLayoutConstraint(item: rightNav.view, attribute: .top, relatedBy: .equal, toItem: detailContainerView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: rightNav.view, attribute: .bottom, relatedBy: .equal, toItem: detailContainerView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: rightNav.view, attribute: .leading, relatedBy: .equal, toItem: detailContainerView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: rightNav.view, attribute: .trailing, relatedBy: .equal, toItem: detailContainerView, attribute: .trailing, multiplier: 1.0, constant: 0),
        ])
        rightNav.didMove(toParentViewController: self)
        // -end

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.menuContainerView?.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        self.showOrHide(self.isMenuShow, animated: false)
    }
}


extension  MasterViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let multiplier = 1.0 / (self.menuContainerView?.bounds.width)!
        let offset = (self.scrollView?.contentOffset.x)! * multiplier
        let fraction = 1.0 - offset
        
        // Begin layer 3d transform
        self.menuContainerView?.layer.transform = self.get3dTransform(fraction)
        print(fraction)
        self.menuContainerView?.alpha = fraction
        
        if let detailViewCtl = self.detailViewCtl {
            if let menuButton = detailViewCtl.menuButton {
                menuButton.rotate(fraction)
            }
        }
        
        self.scrollView?.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)
        
        let menuOffset = self.menuContainerView?.bounds.width
        self.isMenuShow = !CGPoint(x: menuOffset!, y: 0).equalTo((self.scrollView?.contentOffset)!)
    }
    
    func get3dTransform(_ fraction: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0
        let angle = CGFloat(1.0 - fraction) * -CGFloat(M_PI_2)
        let xOffset = (self.menuContainerView?.bounds.width)! / 2
        let rotateTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0, 0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
}

extension  MasterViewController: SidebarAnimationDelegate {
    func showOrHide(_ show: Bool, animated: Bool) {
        let xOffset = self.menuContainerView!.bounds.width
        let point = show ? CGPoint.zero : CGPoint(x: xOffset, y: 0)
        
        self.scrollView?.setContentOffset(point, animated: animated)
        self.isMenuShow = show
    }
}
