//
//  RACExtensions.swift
//
//  Created by AvdLee on 28/10/15.
//  Copyright (c) 2014 A. van der Lee. All rights reserved.
//

import Foundation
import ReactiveCocoa

public struct RAC  {
    var target: NSObject
    var keyPath: String
    var nilValue: AnyObject?
    
    public init(_ target: NSObject, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(_ signal : RACSignal) -> RACDisposable {
        return signal.setKeyPath(self.keyPath, on: self.target, nilValue: self.nilValue)
    }
}

infix operator <~ {
associativity right
precedence 93
}

@discardableResult
public func <~ (rac: RAC, signal: RACSignal) -> RACDisposable {
    return signal ~> rac
}

@discardableResult
public func ~> (signal: RACSignal, rac: RAC) -> RACDisposable {
    return rac.assignSignal(signal)
}

public func RACObserve(_ target: NSObject!, _ keyPath: String) -> RACSignal {
    return target.rac_values(forKeyPath: keyPath, observer: target)
}
