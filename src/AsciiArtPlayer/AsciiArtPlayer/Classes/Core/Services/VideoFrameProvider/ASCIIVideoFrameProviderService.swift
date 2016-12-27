//
//  ASCIIVideoFrameProviderService.swift
//  SwiftAsciiArt
//
//  Created by Sergey Teryokhin on 16/12/2016.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

/// Class to generate frames for given Video URL
class ASCIIVideoFrameProviderService : VideoFrameProviderServiceProtocol {
    private var asset: AVAsset
    private var generator: AVAssetImageGenerator?

    /// Configuration for the class like: font, max size, etc
    var configuration: ASCIIVideoFrameProviderConfiguration!
    
    /// Time for last frame created
    public var currentTime: CGFloat = 0.0
    
    @available(*, unavailable, message: "Use designated initialiser")
    init() {
        fatalError()
    }
    
    init(assetURL: URL, configuration: ASCIIVideoFrameProviderConfiguration = ASCIIVideoFrameProviderConfiguration.defaultConfiguration()) {
        self.asset = AVAsset(url: assetURL)
        self.configuration = configuration
        
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: self.asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.requestedTimeToleranceAfter = kCMTimeZero;
        assetImgGenerate.requestedTimeToleranceBefore = kCMTimeZero;
        
        self.generator = assetImgGenerate
    }
    
    func nextFrame() -> UIImage? {
        return nil
    }
    
    func frameWithTime(time: CGFloat, callback: @escaping (_ asciiString: String, _ nextTime: CGFloat) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            //let startTime = Date()
            let cmTime        : CMTime = CMTimeMakeWithSeconds(Float64(time), 600)
            let img         : CGImage = try! self.generator!.copyCGImage(at: cmTime, actualTime: nil)
            let frameImg    : UIImage = UIImage(cgImage: img)
            
            // Rotate first because the orientation is lost when resizing.
            let rotatedImage = frameImg.imageRotatedToPortraitOrientation()
            let resizedImage = rotatedImage.imageConstrainedToMaxSize(self.configuration.maxImageSize)
            //print("resizedImage: \(resizedImage.size)")
            let asciiArtist  = AsciiArtist(resizedImage, self.configuration.palette)
            let asciiArt     = asciiArtist.createAsciiArt()

            self.currentTime += 0.1
            //callback(asciiArt, time + CGFloat(startTime.timeIntervalSinceNow))
            callback(asciiArt, self.currentTime)
        }
    }
}
