//
//  AssetLoaderModuleOutput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 28/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import Foundation

protocol AssetLoaderModuleOutput : class, RamblerViperModuleOutput {
    func cancelAssetLoader(module: RamblerViperModuleTransitionHandlerProtocol)
    
    func completeAssetLoader(module: RamblerViperModuleTransitionHandlerProtocol, url: URL)
}
