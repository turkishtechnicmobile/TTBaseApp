//
//  Localizable.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 17.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

public extension Localizable {
    // default Localizable.strings file name
    var tableName: String {
        return "Localizable"
    }
}

public extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}

extension String {
    /// Use for localization
    public func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "###\(self)###", comment: "")
    }
}

@propertyWrapper
public struct Localized<Value> {
    
    public var wrappedValue: Value
    public var projectedValue: String {
        return ""
    }

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
