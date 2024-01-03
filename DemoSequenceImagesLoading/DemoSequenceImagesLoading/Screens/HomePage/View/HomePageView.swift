//
//  HomePageView.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//
//

import SwiftUI
import UIKit
import SequenceImagesLoading

// MARK: HomePageView
/// protocol HomePageView
protocol HomePageViewProtocol: BaseViewProtocol {
    
}

// MARK: constIDViewHomePageView
/// List IDview of all views as a const variable
struct constIDViewHomePageView {
    static let _idView_MainZStack = "_idView_MainZStack"
    static let _idView_MainVStack = "_idView_MainVStack"
    static let _idView_SequenceImagesLoadingView = "_idView_SequenceImagesLoadingView"
    static let _idView_SyncButton = "_idView_SyncButton"
    static let _idView_SyncTextBUtton = "_idView_SyncTextBUtton"
    static let _idView_NumberPercentageText = "_idView_NumberPercentageText"
}

// MARK: HomePageView
/// Contruct main view in here
struct HomePageView : View, HomePageViewProtocol {
    @ObservedObject var hpViewModel: HomePageViewModel
    
    // init SequenceImagesLoading
    var body: some View {
        // add ZStack
        ZStack{
            // set background color
            Color.green
            
            // add SequenceImagesLoadingView
            SequenceImagesView(numPercentage: $hpViewModel.numPercentage)
            
            // add VStack
            VStack {
                // add sync button
                Button {
                    hpViewModel.syncData()
                } label: {
                    syncButton(syncStatus: $hpViewModel.syncStatus)
                }
                .offset(y: 350)
                .id(constIDViewHomePageView._idView_SyncButton)
                
                // add textview to display number of percentage
                textNumPercentageView(numPercentage: $hpViewModel.numPercentage)
            }
            .id(constIDViewHomePageView._idView_MainVStack)
        }
        .ignoresSafeArea(.all)
        .id(constIDViewHomePageView._idView_MainZStack)
    }
}

// MARK: syncButton
/// Contruct textview of sync button
struct syncButton : View {
    @Binding var syncStatus: SyncDataStatus
    
    var body: some View {
        return Text(syncStatus.name)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(syncStatus == .Syncing ? Color.orange:Color.purple)
            .cornerRadius(15.0)
            .allowsHitTesting(syncStatus != .Syncing)
            .id(constIDViewHomePageView._idView_SyncTextBUtton)
    }
}

// MARK: textNumPercentageView
/// Contruct textview to update number percentage
struct textNumPercentageView : View {
    @Binding var numPercentage: TimeInterval
    var body: some View {
        return Text(String.stringFromPercentageNumber(numPercentage: numPercentage))
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .offset(y:-40)
            .id(constIDViewHomePageView._idView_NumberPercentageText)
    }
}

// MARK: SequenceImagesView
/// Contruct SequenceImagesView
struct SequenceImagesView : View {
    @Binding var numPercentage: TimeInterval
    @State var repeatTimes: Int = 0
    
    var body: some View {
        // declare image file name and image bundle name which bundle these images were stored
        let strImageFileName = "ks_activity_seq_"
        let strImageBundleName = "Assets_Katespade_Activity"
        var arrImageFiles: [SequenceImageFile] = [SequenceImageFile]()
        
        for idx in 0...72 {
            let strFileName = strImageFileName + String.stringFromInt(idx, numberZeroChar: 3)
            arrImageFiles.append(SequenceImageFile(fileName: strFileName, inBundleName: strImageBundleName))
        }
        
        return SequenceImagesLoadingView(duration: $numPercentage, repeatTimes: $repeatTimes, arrImageFiles: arrImageFiles)
            .frame(width: 400.0, height: 400.0)
    }
}

// MARK: Preview
#Preview {
    let model = HomePageModel(userActivityModule: UserActivityDataServices.sharedInstance)
    let viewmodel = HomePageViewModel(hgModel: model)
    return HomePageView(hpViewModel: viewmodel)
}
