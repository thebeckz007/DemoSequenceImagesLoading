//
//  MockHomePageViewModel.swift
//  DemoSequenceImagesLoadingTests
//
//  Created by Phan Anh Duy on 18/11/2023.
//

import Foundation

@testable import DemoSequenceImagesLoading

class MockHomePageViewModel: HomePageViewModel {
    override func syncData() {
        self.numPercentage = 0.7
        self.syncStatus = .SyncCompleted
    }
}
