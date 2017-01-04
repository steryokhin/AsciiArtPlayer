//
//  PlayerPlayerInteractorOutput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import Foundation

protocol PlayerInteractorOutput: class {
    func interactorConfigured(withService service: VideoFrameProviderServiceProtocol)
}
