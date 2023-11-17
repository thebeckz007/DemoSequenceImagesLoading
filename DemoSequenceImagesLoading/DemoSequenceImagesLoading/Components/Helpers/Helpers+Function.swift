//
//  Helpers+Function.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//

import Foundation

public func dispatchMain(_ block: @escaping ()->()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}
