//
//  MockUserActivityDataServices.swift
//  DemoSequenceImagesLoadingTests
//
//  Created by Phan Anh Duy on 18/11/2023.
//

import Foundation

@testable import DemoSequenceImagesLoading

class MockUserActivityDataServices: UserActivityDataServicesProtocol {
    func getUserStepsData(completion: @escaping getUserStepsDataCompletion) {
        completion(7000)
    }
    
    func getUserActivityData(completion: @escaping getUsersActivityDataCompletion) {
        completion(0.7)
    }
}
