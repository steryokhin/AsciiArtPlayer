//
//  ASCIIVideoFrameProviderService.swift
//  SwiftAsciiArt
//
//  Created by Sergey Teryokhin on 16/12/2016.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//

import QorumLogs
import UIKit
import AVFoundation
import Foundation



/// Class to generate frames for given Video URL
class ASCIIVideoFrameProviderService: VideoFrameProviderServiceProtocol {
    private var asset: AVAsset
    private var generator: AVAssetImageGenerator

    /// Configuration for the class like: font, max size, etc
    var configuration: VideoFrameProviderConfiguration!
    weak var delegate: VideoFrameProviderServiceDelegate?

    /// Time for last frame created
    //public var currentTime: CGFloat = 0.0

    @available(*, unavailable, message: "Use designated initialiser")
    init() {
        fatalError()
    }

    init(avAsset: AVAsset, configuration: VideoFrameProviderConfiguration = VideoFrameProviderConfiguration.defaultConfiguration()) {
        self.asset = avAsset
        self.configuration = configuration
        
        let assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: self.asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.requestedTimeToleranceAfter = kCMTimeZero;
        assetImgGenerate.requestedTimeToleranceBefore = kCMTimeZero;

        self.generator = assetImgGenerate
    }
    
    func nextFrame() {
        //TODO: implement me
    }


    func frameWithTime(time: CGFloat) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            do {
                let cmTime: CMTime = CMTimeMakeWithSeconds(Float64(time), 600)
                let img: CGImage = try self.generator.copyCGImage(at: cmTime, actualTime: nil)
                let frameImg: UIImage = UIImage(cgImage: img)

                // Rotate first because the orientation is lost when resizing.
                let rotatedImage = frameImg.imageRotatedToPortraitOrientation()
                let resizedImage = rotatedImage.imageConstrainedToMaxSize(self.configuration.maxImageSize)
                let asciiArtist = AsciiArtist(resizedImage, self.configuration.palette)
                let asciiArt = asciiArtist.createAsciiArt()

                guard let myDelegate = self.delegate else {
                    return
                }
                myDelegate.frameComplete(withString: asciiArt, forTime: time)
            } catch let error {
                guard let myDelegate = self.delegate else {
                    return
                }

                myDelegate.frameFailed(withError: error)
            }
        }
    }
}
