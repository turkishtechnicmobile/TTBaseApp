//
//  Dependency.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 13.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public struct TTDependency {
    static private var factories: [ObjectIdentifier : () -> Any] = [:]
    
    public static func register<T>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        self.factories[ObjectIdentifier(type)] = factory
    }
    
    public static func resolve<T>() -> T {
        guard let component = factories[ObjectIdentifier(T.self)]?() as? T else {
            fatalError("Dependency class \(T.self) cann't resolved!")
            }
        return component
    }
    
    public static func resolve<T>(_ type: T.Type) -> T {
        guard let component = factories[ObjectIdentifier(type)]?() as? T else {
            fatalError("Dependency class \(T.self) can not resolved!")
            }
        return component
    }
}

@propertyWrapper
public struct Inject<Value> {
    public var wrappedValue: Value {
        get {
            return TTDependency.resolve()
        }
    }
    public init() {}
}
