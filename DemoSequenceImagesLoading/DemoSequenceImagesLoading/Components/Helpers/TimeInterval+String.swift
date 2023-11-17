//
//  TimeInterval+String.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//

import Foundation

extension TimeInterval {
    public func toStringPercentage() -> String {
        return max(Int(self * 100),0).toStringPercentage()
    }
}
