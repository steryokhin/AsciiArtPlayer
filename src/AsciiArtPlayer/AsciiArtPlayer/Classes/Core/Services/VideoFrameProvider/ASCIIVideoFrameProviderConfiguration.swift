//
//  ASCIIVideoFrameConfiguration.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 26/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import Foundation

/// Configuration class for video frame provider service
struct VideoFrameProviderConfiguration {
    public let labelFont: UIFont
    public let maxImageSize: CGSize
    public lazy var palette: AsciiPalette = AsciiPalette(font: self.labelFont)
    
    @available(*, unavailable, message: "Use designated initialiser")
    init() {
        fatalError()
    }
    
    init(_ labelFont: UIFont, _ maxImageSize: CGSize) {
        self.labelFont = labelFont
        self.maxImageSize = maxImageSize
    }
    
    static func defaultConfiguration() -> VideoFrameProviderConfiguration {
        let configuration = VideoFrameProviderConfiguration(UIFont(name: "Courier", size: 8)!, CGSize(width: 200, height: 200))
        
        return configuration
    }
}
