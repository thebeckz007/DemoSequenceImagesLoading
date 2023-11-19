//
//  HomePageViewModelTest.swift
//  DemoSequenceImagesLoadingTests
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import Quick
import Nimble
import Foundation

@testable import DemoSequenceImagesLoading

class HomePageViewModelTestSpec: QuickSpec {
    override class func spec() {
        var hpViewModel: HomePageViewModel?

        beforeEach {
            let mockModel: HomePageModelProtocol = MockHomePageModel()
            hpViewModel = HomePageViewModel(hgModel: mockModel)
        }
        
        // testsuite of published var
        describe("Test published var") {
            // testsuite of numPercentage var
            context("Test numPercentage var") {
                // testcase numPercentage with default value
                var expctedValue: TimeInterval = 0
                it("Test numPercentage with default value 0") {
                    expect(hpViewModel?.numPercentage).to(equal(expctedValue))
                }
                
                // testcase update numPercentage
                it("Test update numPercentage") {
                    expctedValue = 0.5
                    hpViewModel?.numPercentage = expctedValue
                    
                    expect(hpViewModel?.numPercentage).to(equal(expctedValue))
                }
            }
            
            // testsuite of syncStatus var
            context("Test func syncStatus") {
                // testcase syncStatus with default value
                var expctedValue: SyncDataStatus = .NotSync
                it("Test syncStatus with default value .NotSync") {
                    expect(hpViewModel?.syncStatus).to(equal(expctedValue))
                }
                
                // testcase update syncStatus to syncing
                it("Test update syncStatus to syncing") {
                    expctedValue = .Syncing
                    hpViewModel?.syncStatus = expctedValue
                    
                    expect(hpViewModel?.syncStatus).to(equal(expctedValue))
                }
                
                // testcase update syncStatus to sync completed
                it("Test update syncStatus to sync completed") {
                    expctedValue = .SyncCompleted
                    hpViewModel?.syncStatus = expctedValue
                    
                    expect(hpViewModel?.syncStatus).to(equal(expctedValue))
                }
            }
            
            // testsuite of txtSyncStatus var
            context("Test func txtSyncStatus") {
                // testcase syncStatus with default value
                var expctedValue: String = SyncDataStatus.NotSync.name
                it("Test txtSyncStatus with default value .NotSync") {
                    expect(hpViewModel?.txtSyncStatus).to(equal(expctedValue))
                }
                
                // testcase update txtSyncStatus to syncing
                it("Test update txtSyncStatus to syncing") {
                    expctedValue = SyncDataStatus.Syncing.name
                    hpViewModel?.txtSyncStatus = expctedValue
                    
                    expect(hpViewModel?.txtSyncStatus).to(equal(expctedValue))
                }
                
                // testcase update txtSyncStatus to sync completed
                it("Test update txtSyncStatus to sync completed") {
                    expctedValue = SyncDataStatus.SyncCompleted.name
                    hpViewModel?.txtSyncStatus = expctedValue
                    
                    expect(hpViewModel?.txtSyncStatus).to(equal(expctedValue))
                }
            }
        }
        
        // testsuite of methods
        describe("Test method") {
            // test sync data method
            context("test sync data method") {
                it("Test sync data with respond 0.7") {
                    hpViewModel?.hgModel.syncData(completion: { data in
                        expect(data).to(equal(0.7))
                    })
                }
            }
        }
    }
}
