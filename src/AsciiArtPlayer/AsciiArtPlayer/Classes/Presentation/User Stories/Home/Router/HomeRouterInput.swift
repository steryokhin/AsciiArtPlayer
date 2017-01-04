//
//  HomeHomeRouterInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import Foundation

protocol HomeRouterInput {
    func showPlayer(delegate: RamblerViperModuleOutput?, url: URL)
    
    func showAssetLoader(delegate: RamblerViperModuleOutput?)
    
    func showCameraRecorder(delegate: RamblerViperModuleOutput?)    
}

