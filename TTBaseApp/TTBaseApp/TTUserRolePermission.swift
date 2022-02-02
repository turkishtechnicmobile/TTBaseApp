//
//  UserPermissions.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 3.12.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import UIKit

public protocol Menu {

    var value:String { get }
    func getName() -> String
    func getIcon() -> UIImage?
    static func setMenus(links: [String])
}

public protocol TTPermission {
    var value:String { get }
    static func hasPermission(check: TTPermission) -> Bool
    static func setPermissions(links: [String])
}


