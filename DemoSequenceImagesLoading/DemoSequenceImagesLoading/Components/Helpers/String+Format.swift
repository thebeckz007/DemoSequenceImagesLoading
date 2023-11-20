//
//  String+Format.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//

import Foundation

extension String {
    static public func stringFromInt(_ number: Int, numberZeroChar: Int) -> String {
        var formatString = ""
        let numZero = numberZeroChar - String(number).count
        if numZero > 0 {
            for _ in 1...numZero {
                formatString += "0"
            }
        }
        formatString += "%d"
        return String(format: formatString, number)
    }
}
