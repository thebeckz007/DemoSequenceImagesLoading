//
//  HomePageViewModel.swift
//  DemoSequenceImagesLoading
//
//  Created by Phan Anh Duy on 16/11/2023.
//
//

import Foundation

// MARK: enum SyncDataStatus
/// List all status of syncing data
enum SyncDataStatus: Int {
    /// Not started syncing
    case NotSync = 0
    
    /// In syncing progress
    case Syncing = 1
    
    /// Just completed syncing
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

// MARK: protocol HomePageViewModelProtocol
/// protocol HomePageViewModelProtocol
protocol HomePageViewModelProtocol: BaseViewModelProtocol {
    /// Perform a syncing data
    func syncData()
}

// MARK: Class HomePageViewModel
/// Class HomePageViewModel
class HomePageViewModel: ObservableObject, HomePageViewModelProtocol {
    @Published var numPercentage: TimeInterval = 0
    @Published var syncStatus: SyncDataStatus = .NotSync
    @Published var txtSyncStatus: String = SyncDataStatus.NotSync.name
    
    var hgModel: HomePageModelProtocol
    
    init(hgModel: HomePageModelProtocol) {
        self.hgModel = hgModel
    }
    
    func syncData() {
        self.syncStatus = .Syncing
        hgModel.syncData { data in
            self.numPercentage = data ?? 0
            self.syncStatus = .SyncCompleted
        }
    }
}
