//
//  HomePageView.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//
//

import SwiftUI
import UIKit

// Mark: Struct HomePageView
struct HomePageView : View {
    @ObservedObject var hpViewModel = HomePageViewModel()
    
    // init SequenceImagesLoading
    var body: some View {
        ZStack{
            Color.green
            SequenceImagesLoadingView(numPercentage: $hpViewModel.numPercentage)
            VStack {
                Button(action: {
                    hpViewModel.syncData()
                }) {
                    syncButton(syncStatus: $hpViewModel.syncStatus)
                }
                .offset(y: 350)
                
                textView(numPercentage: $hpViewModel.numPercentage)
            }
        }
        .ignoresSafeArea(.all)
    }
}

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
    }
}

struct textView : View {
    @Binding var numPercentage: TimeInterval
    var body: some View {
        return Text(numPercentage.toStringPercentage())
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .offset(y:-40)
    }
}

struct SequenceImagesLoadingView : View {
    @Binding var numPercentage: TimeInterval
    var body: some View {
        return SequenceImagesLoadingUIImageView(numPercentage: $numPercentage)
            .frame(width: 400.0, height: 400.0)
    }
}

struct SequenceImagesLoadingUIImageView: UIViewRepresentable {
    //1.
    typealias UIViewType = SequenceImagesLoading

    //2.
    @Binding var numPercentage: TimeInterval

    //3.
    func makeUIView(context: Context) -> SequenceImagesLoading {
        var arrImageFiles: [String] = [String]()
        for idx in 0...72 {
            let strFileName = "ks_activity_seq_" + String.stringFromInt(idx, numberZeroChar: 3)
            arrImageFiles.append(strFileName)
        }
        
        let result = SequenceImagesLoading(sequenceImageFileNames: arrImageFiles, imageType: .png, inBundleName: "Assets_Katespade_Activity")
        result.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        result.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
        
        return result
    }
    
    //4.
    func updateUIView(_ uiView: SequenceImagesLoading, context: Context) {
        uiView.startAnimation(duration: numPercentage) { _ in
        }
    }
}

// MARK: Preview
#Preview {
    HomePageView()
}
