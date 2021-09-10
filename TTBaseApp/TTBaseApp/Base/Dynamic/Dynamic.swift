//
//  Dynamic.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 13.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public class Dynamic<Value>: Disposable {
    public typealias Listener = (Value) -> ()
    public var listener: Listener?
    
    private let scheduler: DispatchQueue?
    private var _value: Value
    public var value: Value {
        get {
            return _value
        }
        set {
            send(newValue)
        }
    }
    
    public init(_ value: Value, on scheduler: DispatchQueue? = .main) {
        _value = value
        self.scheduler = scheduler
    }
    
    @discardableResult
    public func bind(_ listener: Listener?) -> Disposable {
        self.listener = listener
        return self
    }
    
    @discardableResult
    public func bindAndFire(_ listener: Listener?) -> Disposable {
        self.listener = listener
        listener?(value)
        return self
    }
    
    public func dispose() {
        listener = nil
    }
    
    private func send(_ value: Value) {
        _value = value
        if let scheduler = scheduler {
            scheduler.async { [weak self] in
                self?.listener?(value)
            }
        } else {
            listener?(value)
        }
    }
}
