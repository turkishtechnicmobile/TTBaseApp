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
    
    public func animateSwipeAction (cell:UITableViewCell) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            var swipeLabel: UILabel? = UILabel.init(frame: CGRect(x: cell.bounds.size.width, y: 0, width: 200, height: cell.bounds.size.height))
            
            swipeLabel!.text = "  Swipe";
            swipeLabel!.backgroundColor = #colorLiteral(red: 1, green: 0.1607843137, blue: 0.2078431373, alpha: 1)
            swipeLabel!.textColor = UIColor.white
            cell.addSubview(swipeLabel!)
            
            UIView.animate(withDuration: 0.5, animations: {
                cell.frame = CGRect(x: cell.frame.origin.x - 100, y: cell.frame.origin.y, width: cell.bounds.size.width + 100, height: cell.bounds.size.height)
            }) { (finished) in
                UIView.animate(withDuration: 0.3, animations: {
                    
                    cell.frame = CGRect(x: cell.frame.origin.x + 100, y: cell.frame.origin.y, width: cell.bounds.size.width - 100, height: cell.bounds.size.height)
                    
                }, completion: { (_) in
                    swipeLabel?.removeFromSuperview()
                    swipeLabel = nil;
                })
            }
        }
    }
}
