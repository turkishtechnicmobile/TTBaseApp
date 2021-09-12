//
//  ConfirmationAlert.swift
//  TTBaseApp
//
//  Created by Remzi YILDIRIM on 17.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol ConfirmationAlert {
    var title: String? { get set }
    var message: String? { get set}
    var style: AlertStyle { get set }
    var actionPreferred: ActionPreferred {get set}
    var cancelActionTitle: String? { get set}
    var cancelActionStyle: ActionStyle { get }
    var cancelActionHandler: (() -> ())? { get }
    var okActionTitle: String? { get set}
    var okActionStyle: ActionStyle { get}
    var okActionHandler: (() -> ())? { get }
}

public enum AlertStyle: Int {
    case actionSheet
    case alert
}

public enum ActionStyle: Int {
    case `default`
    case cancel
    case destructive
}

public enum ActionPreferred {
    case none
    case cancel
    case ok
}
