//
//  MockHomePageModel.swift
//  DemoSequenceImagesLoadingTests
//
//  Created by Phan Anh Duy on 18/11/2023.
//

import Foundation

@testable import DemoSequenceImagesLoading

class MockHomePageModel: HomePageModelProtocol {
    var mockSyncDataValue: TimeInterval = 0
    
    func syncData(completion: @escaping (_ data: TimeInterval?) -> Void) {
        completion(0.7)
    }
    
    func checkUserData() -> Bool {
        // TODO
        return true
    }
}
