//
//  HomeHomeRouterInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import Foundation
import AVFoundation

protocol HomeRouterInput {
    func showPlayer(delegate: RamblerViperModuleOutput?, avAsset: AVAsset)
    
    func showAssetLoader(delegate: RamblerViperModuleOutput?)
    
    func showCameraRecorder(delegate: RamblerViperModuleOutput?)    
}

