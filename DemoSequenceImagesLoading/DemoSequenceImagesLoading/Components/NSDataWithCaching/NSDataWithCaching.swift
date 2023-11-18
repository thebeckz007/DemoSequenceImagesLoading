//
//  NSDataWithCaching.swift
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Foundation

// MARK: completion block
// Define completion block
typealias getDataWithCachingCompletion = (_ data: Data?) -> Void;
typealias saveDataWithCachingCompletion = () -> Void;

// MARK: Protocol CachingFileDataProtocol
// Protocol CachingFileDataProtocol
protocol CachingFileDataProtocol {
    func getDataFilebyFileName(_ filename: String, inMainThread: Bool, completion: @escaping getDataWithCachingCompletion)
    func clearCaching()
}

// MARK: Class DataWithCaching
// Class DataWithCaching
class NSDataWithCaching: NSObject, CachingFileDataProtocol {
    // Inint shared instance as a Singleton instance
    static let sharedInstance = NSDataWithCaching();
    
    // Init a cuncurrent queue for performing Data caching task
    private let queueDataCaching: DispatchQueue = DispatchQueue(label: "__DATACACHING_QUEUE__", attributes: .concurrent);
    
    // Init cachingData to store data
    private var cachingData: [String: Data] = [String: Data]();
    
    // Function read data file by file name
    func getDataFilebyFileName(_ filename: String, inMainThread: Bool = true, completion: @escaping getDataWithCachingCompletion) {
        // Declare finalCompletion as a final completion to perform this completion
        let finalCompletion: getDataWithCachingCompletion = { data in
            if inMainThread {
                DispatchQueue.main.async {
                    completion(data)
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
    func clearCaching() {
        self.threadSafe() {
            self.cachingData.removeAll();
        }
    }
    
    // Function get data from caching by key of file
    private func getDataFromCaching(_ keyFile: String, completion: getDataWithCachingCompletion) {
        self.threadSafe() {
            if let data = self.cachingData[keyFile] {
                completion(data);
            } else {
                completion(nil);
            }
        }
    }
    
    // Function store data to caching by key of file
    private func saveDataToCaching(_ keyFile: String, data: Data, completion: saveDataWithCachingCompletion) {
        self.threadSafe() {
            self.cachingData[keyFile] = data;
            completion();
        }
    }
}
