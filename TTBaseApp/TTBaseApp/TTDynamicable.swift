//
//  Dynamicable.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 27.05.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

@propertyWrapper
//@dynamicMemberLookup
public struct TTDynamicable<Value> {
    private let lock = NSLock()
    private var privateValue: Value
    public var projectedValue: TTDynamic<Value>
    
    public var wrappedValue: Value {
        get {
            return privateValue
        }
        set {
            setValueSafe(newValue)
        }
    }
    
    public init(wrappedValue: Value) {
        projectedValue = TTDynamic(wrappedValue)
        self.privateValue = wrappedValue
    }
    
    private mutating func setValueSafe(_ newValue: Value) {
        defer { lock.unlock() }
        lock.lock()
        privateValue = newValue
        projectedValue.value = newValue
    }
    
//    public subscript<Property>(dynamicMember keyPath: WritableKeyPath<Value, Property>) -> Dynamic<Property> {
//        Dynamic(wrappedValue[keyPath: keyPath])
//    }
}
