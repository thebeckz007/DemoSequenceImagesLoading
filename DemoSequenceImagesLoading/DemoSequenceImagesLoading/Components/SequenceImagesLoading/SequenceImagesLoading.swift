//
//  SequenceImagesLoading.swift
//
//  Created by Phan Anh Duy on 17/11/2023.
//

import UIKit

// MARK: Enum SequenceImageFileType
public enum SequenceImageFileType : Int {
    case png = 1
    case jpg = 2
    
    var name : String {
        switch self {
        case .png:
            return "png"
        case .jpg:
            return "jpg"
        }
    }
}

// MARK:
// Define
public typealias SequenceImagesAnimationCompletion = (Bool) -> Void

// MARK: Protocol
protocol SequenceImagesLoadingProtocol {
    func startAnimation(duration: TimeInterval, repeatTimes: Int, completion: SequenceImagesAnimationCompletion?)
    func stopAnimation()
}

// MARK: Class SequenceImagesLoading
open class SequenceImagesLoading: UIImageView, SequenceImagesLoadingProtocol {
    // MAR:- Variables
    fileprivate var sequenceImageFiles: [String] = [String]()
    fileprivate var imageCompletionAnimation: SequenceImagesAnimationCompletion?
    
    fileprivate var repeatTimes: Int = 0
    fileprivate var curIndex: Int = 0
    fileprivate var toIndex: Int = 0
    fileprivate var animateNext: Bool = true;  // true if animate to Next, false if animate to Previous
    
    fileprivate var dataCachingModule: CachingFileDataProtocol?
    fileprivate var timer: Timer?
    
    convenience init(sequenceImageFiles: [String], dataCachingModule: CachingFileDataProtocol) {
        self.init();
        
        self.sequenceImageFiles = sequenceImageFiles
        self.dataCachingModule = dataCachingModule
        
        preloadSequenceImages()
    }
    
    //
    convenience init(sequenceImageFileNames: [String], imageType: SequenceImageFileType = .png, inBundle: Bundle, dataCachingModule: CachingFileDataProtocol) {
        // read data of all image animation filess in other queue
        var arrImageFiles: [String] = [String]()
        
        for file in sequenceImageFileNames {
            if let pathFile = file.pathFileInBundle(inBundle, withExtensionFile: imageType.name) {
                arrImageFiles.append(pathFile);
            }
        }
        
        self.init(sequenceImageFiles: arrImageFiles, dataCachingModule: dataCachingModule)
    }
    
    convenience init(systemImageFileNames: [String], imageType: SequenceImageFileType = .png, dataCachingModule: CachingFileDataProtocol) {
        self.init(sequenceImageFileNames: systemImageFileNames, imageType: imageType, inBundle: Bundle.main, dataCachingModule: dataCachingModule)
    }
    
    convenience init(sequenceImageFileNames: [String], imageType: SequenceImageFileType = .png, inBundleName: String, dataCachingModule: CachingFileDataProtocol) {
        // read data of all image animation filess in other queue
        let path = Bundle.main.path(forResource:inBundleName, ofType:"bundle")
        let bundleImages :Bundle = Bundle.init(path: path!)!
        
        self.init(sequenceImageFileNames: sequenceImageFileNames, imageType: imageType, inBundle: bundleImages, dataCachingModule: dataCachingModule)
    }
    
    //
    private func preloadSequenceImages() {
        for pathFile in sequenceImageFiles {
            self.dataCachingModule?.getDataFilebyFileName(pathFile, inMainThread: true, completion: { (data) in
            })
        }
    }
    
    /**
     NOTE: Auto animate from previous index to next index
     NOTE: if duration is zero, this progress should not animate.
     NOTE: repeatTimes = -1: loop forever
     */
    open func startAnimation(duration: TimeInterval = 1.0, repeatTimes: Int = 0, completion: SequenceImagesAnimationCompletion?) {
        if self.sequenceImageFiles.count == 0 {
            return
        }
        
        self.repeatTimes = repeatTimes;
        
        self.imageCompletionAnimation = completion;
        self.toIndex = max(Int(round(Float(duration) * Float(self.sequenceImageFiles.count))),0)
        
        if self.toIndex > self.curIndex {
            // animate next from curIndex to toIndex
            self.animateNext = true;
        } else if self.toIndex < self.curIndex {
            // animate previous from curIndex to toIndex
            self.animateNext = false;
        } else {
            // do not at all
            endAnimationPathFileName()
            return
        }
        
        // Stop timer
        self.stopTimer();
        
        // Trigger new timer
        let timeLoadSteps = 0.1
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeLoadSteps), target: self, selector: #selector(self.animateLoadImage), userInfo: nil, repeats: true);
    }
    
    // stop animation
    open func stopAnimation() {
        self.endAnimationPathFileName();
    }
    
    // perform animation by update next image
    @objc private func animateLoadImage() {
        if ((self.animateNext && self.curIndex <= self.toIndex) // in case animate next to
             || (!self.animateNext && self.curIndex >= self.toIndex)) { // in case animate previous to
            
            self.animateAtIndex(self.curIndex);
            
            if self.animateNext {
                // to next
                self.curIndex += 1;
            } else {
                // to previous
                self.curIndex -= 1;
            }
        } else {
            self.repeatAnimationIfNeed();
        }
    }
    
    private func animateAtIndex(_ index: Int) {
        if index < 0 {
            return
        } else if index >= self.sequenceImageFiles.count {
            return
        }
              
        let file = self.sequenceImageFiles[index];
        
        self.dataCachingModule?.getDataFilebyFileName(file, inMainThread: true, completion: { (data) in
            if let _data = data {
                self.image = UIImage(data: _data);
            }
        })
    }
    
    private func repeatAnimationIfNeed() {
        if self.repeatTimes < 0 {
            // loop forever
            self.curIndex = 0;
            self.animateLoadImage();
        } else if (self.repeatTimes >= 1) {
            // loop n times
            self.curIndex = 0;
            self.repeatTimes -= 1;
            self.animateLoadImage();
        } else {
            self.endAnimationPathFileName();
        }
    }
    
    //
    private func endAnimationPathFileName() {
        self.stopTimer();
        
        if let _completion = self.imageCompletionAnimation {
            _completion(true);
            self.imageCompletionAnimation = nil;
        }
    }
    
    //
    private func stopTimer() {
        self.timer?.invalidate();
        self.timer = nil;
    }
}
