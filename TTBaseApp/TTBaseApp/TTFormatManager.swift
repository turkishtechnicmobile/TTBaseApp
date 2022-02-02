//
//  FormatManager.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 21.09.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import Foundation

open class TTFormatManager {
    
    public class func getTimeFormat(hour:Int, minute:Int) -> String {
        
        return String(format: "%.2ld:%.2ld", arguments: [hour, minute])
    }
}
