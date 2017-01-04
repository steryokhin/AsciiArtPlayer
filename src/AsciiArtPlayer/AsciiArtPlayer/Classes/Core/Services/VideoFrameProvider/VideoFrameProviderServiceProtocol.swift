//
//  VideoFrameProviderServiceProtocol.swift
//  SwiftAsciiArt
//
//  Created by Sergey Teryokhin on 16/12/2016.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//

import UIKit
import Foundation

protocol VideoFrameProviderServiceDelegate: class {
    func frameComplete(withString asciiString: String, forTime time: CGFloat)
    
    func frameFailed(withError error: Error)
}


protocol VideoFrameProviderServiceProtocol: class {
    //FIXME: remove set?
    weak var delegate: VideoFrameProviderServiceDelegate? { get set }
    
    var configuration: VideoFrameProviderConfiguration! { get }
    
    func nextFrame()
    func frameWithTime(time: CGFloat)
}

