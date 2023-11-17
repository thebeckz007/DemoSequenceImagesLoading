//
//  String+File.swift
//  
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Foundation

extension String {
    // hash this string into key of string
    internal func keyString() -> String {
        // NOTE: For now, key of file is itself
        return self
    }
}

extension String {
    internal func pathFileFromMainBundleWithExtension(extensionFile: String) -> String? {
        return self.pathFileInBundle(Bundle.main, withExtensionFile: extensionFile)
    }
    
    internal func pathFileInBundle(_ bundle: Bundle, withExtensionFile extensionFile: String) -> String? {
        return bundle.path(forResource: self, ofType: extensionFile) ?? nil
    }
    
    internal func pathFileFromBundleName(_ bundleName: String,withExtensionFile extensionFile: String) -> String? {
        let path = Bundle.main.path(forResource:bundleName, ofType:"bundle")
        let bundleImages :Bundle = Bundle.init(path: path!)!
        
        return self.pathFileInBundle(bundleImages, withExtensionFile: extensionFile)
    }
}
