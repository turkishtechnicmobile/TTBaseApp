//
//  Disposable.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 27.05.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol TTDisposable {
    func dispose()
}

extension TTDisposable {
    public func disposed(by bag: TTDisposeBag) {
        bag.store(self)
    }
}

final public class TTDisposeBag {
    private var disposables = [TTDisposable]()
    
    deinit {
        self.dispose()
    }
    
    public init() {}
    
    func store(_ disposable: TTDisposable) {
        disposables.append(disposable)
    }
    
    private func dispose() {
        disposables.forEach { $0.dispose() }
        disposables.removeAll(keepingCapacity: false)
    }
}

public protocol TTCancelable: TTDisposable { }

final public class TTAnyDisposable: TTCancelable {
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

public struct TTEmptyDisposable: TTCancelable {
 
    static let empty = TTEmptyDisposable()
    
    init() {
    }
    
    public func dispose() {
    }
}


public struct TTDisposables {
    private init() {}
    
    public static func create(with dispose: @escaping () -> Void) -> TTCancelable {
        return TTAnyDisposable(disposeAction: dispose)
    }
    
    public static func create() -> TTCancelable {
        return TTEmptyDisposable.empty
    }
}
