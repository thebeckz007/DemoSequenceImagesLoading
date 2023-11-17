//
//  NSThreadSafe.swift
//
//  Created by Phan Anh Duy on 17/11/2023.
//
import Foundation

extension NSObject {
    public func threadSafe(closure: () -> Void) {
        objc_sync_enter(self)
        closure()
        objc_sync_exit(self)
    }
}
