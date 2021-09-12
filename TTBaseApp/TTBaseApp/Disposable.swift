//
//  Disposable.swift
//  TTBaseApp
//
//  Created by Remzi YILDIRIM on 27.05.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol Disposable {
    func dispose()
}

extension Disposable {
    public func disposed(by bag: DisposeBag) {
        bag.store(self)
    }
}

final public class DisposeBag {
    private var disposables = [Disposable]()
    
    deinit {
        self.dispose()
    }
    
    public init() {}
    
    func store(_ disposable: Disposable) {
        disposables.append(disposable)
    }
    
    private func dispose() {
        disposables.forEach { $0.dispose() }
        disposables.removeAll(keepingCapacity: false)
    }
}

public protocol Cancelable: Disposable { }

final public class AnyDisposable: Cancelable {
    typealias DisposeAction = () -> Void
    
    private var disposeAction: DisposeAction?
    
    init(disposeAction: @escaping DisposeAction) {
        self.disposeAction = disposeAction
    }
    
    public func dispose() {
        if let action = disposeAction {
            disposeAction = nil
            action()
        }
    }
}

public struct EmptyDisposable: Cancelable {
 
    static let empty = EmptyDisposable()
    
    init() {
    }
    
    public func dispose() {
    }
}


public struct Disposables {
    private init() {}
    
    public static func create(with dispose: @escaping () -> Void) -> Cancelable {
        return AnyDisposable(disposeAction: dispose)
    }
    
    public static func create() -> Cancelable {
        return EmptyDisposable.empty
    }
}
