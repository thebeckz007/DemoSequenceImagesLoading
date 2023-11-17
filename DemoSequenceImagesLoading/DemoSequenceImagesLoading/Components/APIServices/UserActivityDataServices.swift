//
//  UserActivityDataServices.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Foundation

//
let TimeIntervalStepDebug: TimeInterval = 1.0

// 
typealias getUserStepsDataCompletion = (_ steps: UInt?) -> Void;
typealias getUsersActivityDataCompletion = (_ data: TimeInterval?) -> Void;

//
class UserActivityDataServices {
    // Inint shared instance as a Singleton instance
    static let sharedInstance = UserActivityDataServices();
    
    func getUserStepsData(completion: @escaping getUserStepsDataCompletion) {
        Timer.scheduledTimer(withTimeInterval: TimeIntervalStepDebug, repeats: false) { _ in
            completion(UInt.random(in: 0...10000))
        }
    }
    
    func getUserActivityData(completion: @escaping getUsersActivityDataCompletion) {
        Timer.scheduledTimer(withTimeInterval: TimeIntervalStepDebug, repeats: false) { _ in
            completion(TimeInterval.random(in: 0.00...1.00))
        }
    }
}
