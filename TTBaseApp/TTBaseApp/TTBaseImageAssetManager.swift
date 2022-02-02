//
//  ImageAssetManager.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 19.09.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import Foundation
import UIKit

open class TTBaseImageAssetManager: NSObject {
    
    public class func image(bundle:Bundle, assetName:String, named name: String) -> UIImage {

        if let image = UIImage(named: name, in: bundle, compatibleWith: nil) {
            
            return image // Load image in cases where Asset is directly integrated
            
        } else if
            let subBundleUrl = bundle.url(forResource: assetName, withExtension: "bundle"),
            let subBundle = Bundle(url: subBundleUrl),
            let image = UIImage(named: name, in: subBundle, compatibleWith: nil)
        {
            
            return image // Load image in cases where Modules is integrated via cocoapods as a dynamic or static framework with a separate resource bundle
        }
        return UIImage()
    }
}

