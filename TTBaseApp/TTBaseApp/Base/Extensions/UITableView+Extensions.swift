//
//  UITableView+Extensions.swift
//  NMBaseApp
//
//  Created by MnzfM on 26.01.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func registerCell<CustomCellType>(customCell:CustomCellType.Type) where CustomCellType : UITableViewCell{
        
        let itemCellNib = UINib(nibName: String(describing: customCell.self), bundle: nil)
        self.register(itemCellNib, forCellReuseIdentifier:  String(describing: customCell.self))
    }
}
