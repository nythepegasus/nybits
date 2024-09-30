//
//  NB+NSObject.swift
//  nybits
//
//  Created by ny on 9/24/24.
//

import Foundation

public extension NSObject {
    @discardableResult
    @inlinable
    func nb_perform(_ selector: Selector, on target: AnyObject) -> Self {
        _ = target.perform(selector, with: self)
        return self
    }
    
    @discardableResult
    @inlinable
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
