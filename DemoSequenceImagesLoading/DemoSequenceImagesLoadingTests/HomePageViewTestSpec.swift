//
//  HomePageViewTestSpec.swift
//  DemoSequenceImagesLoadingTests
//
//  Created by Phan Anh Duy on 18/11/2023.
//

import Quick
import Nimble
import Foundation
import SwiftUI
import ViewInspector

@testable import DemoSequenceImagesLoading

class HomePageViewTestSpec: QuickSpec {
    override class func spec() {
        var hpView: HomePageView?
        
        beforeEach {
            let hgModel = MockHomePageModel()
            let hgViewModel = MockHomePageViewModel(hgModel: hgModel)
            hpView = HomePageView(hpViewModel: hgViewModel)
        }
        
        // testsuite of body view
        describe("Test body view") {
            //
            context("Test zstack") {
                var mainZStack: InspectableView<ViewType.ZStack>?
                
                beforeEach {
                    mainZStack = hpView?.findZStack()
                }
                
                it("has a ZStack with .id 'main_zstack'") {
                    expect(mainZStack).toNot(beNil())
                }
                
                context("test VStack") {
                    var mainVStack: InspectableView<ViewType.VStack>?
                    
                    beforeEach {
                        mainVStack = mainZStack?.findChild(type: ViewType.VStack.self, withId: constIDViewHomePageView._idView_MainVStack)
                    }
                    
                    it("has a VStack with .id 'main_vstack'") {
                        expect(mainVStack).toNot(beNil())
                    }
                    
                    //
                    context("test sync button") {
                        var btnSync: InspectableView<ViewType.Button>?
                        
                        beforeEach {
                            btnSync = mainVStack?.findChild(type: ViewType.Button.self, withId: constIDViewHomePageView._idView_SyncButton)
                        }
                        
                        it("has a btnSync with .id 'sync_button'") {
                            expect(btnSync).toNot(beNil())
                        }
                        
                        //
//                        context("test label of sycn status") {
//                            var lblSyncButton: InspectableView<ViewType.ClassifiedView>?
//                            
//                            beforeEach {
//                                lblSyncButton = try btnSync?.labelView()
//                            }
//                            
//                            it("has a lblSyncButton'") {
//                                expect(lblSyncButton).toNot(beNil())
//                            }
//                            
//                            //
//                            context("test text of sycn status") {
//                                var txtSyncButton: InspectableView<ViewType.Text>?
//                                beforeEach {
////                                    txtSyncButton = try lblSyncButton?.text()
//                                    txtSyncButton =  mainVStack?.findChild(type: ViewType.Text.self, withId: "sync_TextButton")
//                                }
//                                
//                                it("has a textlabel'") {
//                                    expect(txtSyncButton).toNot(beNil())
//                                }
//                                
//                                hpView?.hpViewModel.syncStatus = .NotSync
//                                it("textlabel has text 'Sync'") {
//                                    expect(try txtSyncButton?.string()).to(equal(SyncDataStatus.NotSync.name))
//                                }
//                                
//                                // TODO:
////                                hpView?.hpViewModel.syncStatus = .Syncing
////                                it("textlabel has text ''") {
////                                    expect(try txtSyncButton?.string()).to(equal(SyncDataStatus.Syncing.name))
////                                }
////                                
////                                hpView?.hpViewModel.syncStatus = .SyncCompleted
////                                it("textlabel has text ''") {
////                                    expect(try txtSyncButton?.string()).to(equal(SyncDataStatus.SyncCompleted.name))
////                                }
//                            }
                        }
                    }
                    
                    // test sync textlabel
//                    context("test sync textlabel") {
//                        var txtSync: InspectableView<ViewType.View>?
//                        
//                        beforeEach {
//                            txtSync = mainVStack?.findChild(type: ViewType.View.self, withId: "sync_textview_View")
//                        }
//                        
//                        it("has a textlabel with .id 'sync_textview'") {
//                            expect(txtSync).toNot(beNil())
//                        }
//                        
//                         TODO:
//                        let expectedValue:TimeInterval = 0.7
//                        hpView?.hpViewModel.numPercentage = expectedValue
//                        
//                        it("") {
//                            expect(try txtSync?.string()).to(equal(expectedValue.toStringPercentage()))
//                        }
//                    }
//                }
            }
        }
    }
}
