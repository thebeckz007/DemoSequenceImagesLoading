//
//  NSDataWithCaching.swift
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Foundation

// Define compeition block
typealias getDataWithCachingCompletion = (_ data: Data?) -> Void;
typealias saveDataWithCachingCompletion = () -> Void;

// Class DataWithCaching
class NSDataWithCaching: NSObject {
    // Inint shared instance as a Singleton instance
    static let sharedInstance = NSDataWithCaching();
    
    // Init a cuncurrent queue for performing Data caching task
    fileprivate let queueDataCaching: DispatchQueue = DispatchQueue(label: "__DATACACHING_QUEUE__", attributes: .concurrent);
    
    // Init cachingData to store data
    fileprivate var cachingData: [String: Data] = [String: Data]();
    
    // Function read data file by file name
    internal func dataFilebyFileName(_ filename: String, inMainThread: Bool = false, completion: @escaping getDataWithCachingCompletion) {
        // Declare finalCompletion as a final completion to perform this completion
        let finalCompletion: getDataWithCachingCompletion = { data in
            if inMainThread {
                dispatchMain() {
                    completion(data);
                }
            } else {
                completion(data);
            }
        }
        
        // Get key of file name
        let keyFile = filename.keyString();
        
        // Find data file from the caching by key of file name
        self.getDataFromCaching(keyFile) { (data) in
            if let _data = data {
                finalCompletion(_data);
            } else {
                // Perform to read this file if does not exist from caching
                self.queueDataCaching.async(execute: {
                    if let contentFile = try? Data(contentsOf: URL(fileURLWithPath: filename)) {
                        // store this data to caching by key of file name
                        self.saveDataToCaching(keyFile, data: contentFile, completion: {
                            finalCompletion(contentFile);
                        })
                    } else {
                        finalCompletion(nil);
                    }
                })
            }
        }
    }
    
    // Function ClearCaching
    internal func clearCaching() {
        self.threadSafe() {
            self.cachingData.removeAll();
        }
    }
    
    // Function get data from caching by key of file
    fileprivate func getDataFromCaching(_ keyFile: String, completion: getDataWithCachingCompletion) {
        self.threadSafe() {
            if let data = self.cachingData[keyFile] {
                completion(data);
            } else {
                completion(nil);
            }
        }
    }
    
    // Function store data to caching by key of file
    fileprivate func saveDataToCaching(_ keyFile: String, data: Data, completion: saveDataWithCachingCompletion) {
        self.threadSafe() {
            self.cachingData[keyFile] = data;
            completion();
        }
    }
}
