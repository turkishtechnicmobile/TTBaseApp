//
//  NSObject+Extensions.swift
//  NMBaseApp
//
//  Created by MnzfM on 26.01.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import Foundation

public extension NSObject {

    var className: String {
        return type(of: self).className
    }

    static var className: String {
        return stringFromClass(aClass: self)
    }
}

public func stringFromClass(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
