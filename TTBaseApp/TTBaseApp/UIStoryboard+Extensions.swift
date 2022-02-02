//
//  UIStoryboard+Extensions.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 15.11.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    func instance<T: UIViewController>(of type: T.Type) -> T {
        let identifier = String(describing: T.self)
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}
