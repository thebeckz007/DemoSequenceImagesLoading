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

extension HomePageView: Inspectable {}

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
                    }
                }
            }
        }
    }
}
