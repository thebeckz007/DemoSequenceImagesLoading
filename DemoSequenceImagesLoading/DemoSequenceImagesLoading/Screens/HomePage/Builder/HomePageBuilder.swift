//
//  HomePageBuilder.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 18/11/2023.
//

import Foundation
import SwiftUI

// MARK: protocol HomePageBuilderProtocol
/// protocol HomePageBuilderProtocol
protocol HomePageBuilderProtocol: BaseBuilderProtocol {
    
}

// MARK: class HomePageBuilder
/// class HomePageBuilder
class HomePageBuilder: HomePageBuilderProtocol {
    /// Setup MVVM pattern for HomePage view
    class func setupHomePage() -> HomePageView {
        let model = HomePageModel(userActivityModule: UserActivityDataServices.sharedInstance)
        let viewmodel = HomePageViewModel(hgModel: model)
        let view = HomePageView(hpViewModel: viewmodel)
        
        return view
    }
}
