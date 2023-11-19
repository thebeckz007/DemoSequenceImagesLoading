//
//  HomePageModel.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//
//

import Foundation

// MARK: Protocol HomePageModelProtocol
/// protocol HomePageModelProtocol
protocol HomePageModelProtocol: BaseModelProtocol {
    /// Perform a syncing data
    /// - parameter completion:a completion block what will be fired whenever syncing data completed
    func syncData(completion: @escaping (_ data: TimeInterval?) -> Void)
    
    /// Perform a check user data task
    func checkUserData() -> Bool
}

// MARK: Struct HomePageModel
/// class HomePageModel
class HomePageModel: HomePageModelProtocol {
    let userActivityModule: UserActivityDataServicesProtocol
    
    init(userActivityModule: UserActivityDataServicesProtocol) {
        self.userActivityModule = userActivityModule
    }
    
    func syncData(completion: @escaping (_ data: TimeInterval?) -> Void) {
        userActivityModule.getUserActivityData { data in
            completion(data ?? nil)
        }
    }
    
    func checkUserData() -> Bool {
        // TODO:
        return true
    }
}
