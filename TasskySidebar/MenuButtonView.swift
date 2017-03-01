//
// Created by towry on 01/03/2017.
// Copyright (c) 2017 towry. All rights reserved.
//

import UIKit

// The menu icon on detail navigation bar.
class MenuButtonView: UIView {

    let imageView: UIImageView = UIImageView(image: UIImage(named: "menu"))

    required init(coder aDecoder: NSCoder) {
        // why need unwrapping optional here ..
        super.init(coder: aDecoder)!

        self.setup()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    func rotate(_ fraction: CGFloat) {
        let angle = Double(fraction) * M_PI_2
        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }

    func setup() {
        imageView.contentMode = .center
        self.addSubview(imageView)
    }
}