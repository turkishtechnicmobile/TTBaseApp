//
//  UIImage+Extensions.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 22.09.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import UIKit

public extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: jpegQuality.rawValue)
    }

}
