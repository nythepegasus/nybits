//
//  Debouncer.swift
//  nybits
//
//  Created by ny on 9/24/24.
//

import Foundation

public final class Debouncer {
    private(set) var item: DispatchWorkItem?
    private let interval: TimeInterval
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    func call(_ closure: @escaping () -> Void) {
        item?.cancel()
        item = DispatchWorkItem {
            closure()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: item!)
    }
}
