//
//  HomePageModelTest.swift
//  DemoSequenceImagesLoadingTests
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Quick
import Nimble
import Foundation

@testable import DemoSequenceImagesLoading

class HomePageModelTestSpec: QuickSpec {
    override class func spec() {
        var hpModel: HomePageModel?

        beforeEach {
            let serviceModel = MockUserActivityDataServices()
            hpModel = HomePageModel(userActivityModule: serviceModel)
        }
        
        // testsuite of methods
        describe("Test methods") {
            // testsuite of get steps method
            context("Test get steps method") {
                it("Test get steps with respond 7000 steps") {
                    hpModel?.userActivityModule.getUserStepsData(completion: { data in
                        expect(data).to(equal(7000))
                    })
                }
            }
            
            // // testsuite of get user activity data
            context("Test get user activity data method") {
                it("Test get user activity data with respond 0.7") {
                    hpModel?.userActivityModule.getUserActivityData(completion: { data in
                        expect(data).to(equal(0.7))
                    })
                }
            }
        }
    }
}
