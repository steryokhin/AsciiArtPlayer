//
//  VideoFrameProviderServiceProtocol.swift
//  SwiftAsciiArt
//
//  Created by Sergey Teryokhin on 16/12/2016.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//

import UIKit
import Foundation

protocol VideoFrameProviderServiceProtocol {
    var configuration: ASCIIVideoFrameProviderConfiguration! { get }
    
    func nextFrame() -> UIImage?
    func frameWithTime(time: CGFloat, callback: @escaping (_ asciiString: String, _ nextTime: CGFloat) -> Void)
}

