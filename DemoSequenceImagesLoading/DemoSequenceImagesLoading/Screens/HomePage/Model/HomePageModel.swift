//
//  HomePageModel.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//
//

import Foundation

// Mark: Struct HomePageModel
class HomePageModel {
    func syncData(completion: @escaping (_ data: TimeInterval?) -> Void) {
        UserActivityDataServices.sharedInstance.getUserActivityData { data in
            completion(data ?? nil)
        }
    }
}
