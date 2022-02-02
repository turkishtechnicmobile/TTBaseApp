//
//  TTBaseDateFormatType.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 23.08.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import Foundation

public enum TTBaseDateFormatType: String {
    
    case api = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
    case dateAndTime = "dd.MM.yyyy HH:mm"
    case onlyDate = "dd.MM.yyyy"
    case onlyTime = "HH:mm"
    case dateAndTimeAndSecond = "dd MMM yyyy HH:mm:ss"
}
