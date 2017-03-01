//
// Created by towry on 01/03/2017.
// Copyright (c) 2017 towry. All rights reserved.
//

import Foundation

protocol SidebarAnimationDelegate: NSObjectProtocol {
    func showOrHide(_ show: Bool, animated: Bool)
    func didSelect(_ item: MenuItemType)
}
