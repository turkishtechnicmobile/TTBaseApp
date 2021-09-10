//
//  UICollectionView+Extensions.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 24.05.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func registerCell<CustomCellType>(customCell:CustomCellType.Type) where CustomCellType : UICollectionViewCell{
        
        let itemCellNib = UINib(nibName: String(describing: customCell.self), bundle: nil)
        self.register(itemCellNib, forCellWithReuseIdentifier:  String(describing: customCell.self))
    }
}
