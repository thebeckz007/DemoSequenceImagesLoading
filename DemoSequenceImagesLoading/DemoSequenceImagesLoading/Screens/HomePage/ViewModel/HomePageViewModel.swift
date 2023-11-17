//
//  HomePageViewModel.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//
//

import Foundation

enum SyncDataStatus: Int {
    case NotSync = 0
    case Syncing = 1
    case SyncCompleted = 2
    
    var name : String {
        switch self {
        case .NotSync:
            return "Sync"
        case .Syncing:
            return "Syncing"
        case .SyncCompleted:
            return "Sync Completed"
        }
    }
}

// Mark: Class HomePageViewModel
final class HomePageViewModel: ObservableObject {
    @Published var numPercentage: TimeInterval = 0
    @Published var syncStatus: SyncDataStatus = .NotSync
    @Published var txtSyncStatus: String = SyncDataStatus.NotSync.name
    
    let hgModel = HomePageModel()
    
    func syncData() {
        self.syncStatus = .Syncing
        hgModel.syncData { data in
            self.numPercentage = data ?? 0
            self.syncStatus = .SyncCompleted
        }
    }
}
