//
//  AssetLoaderAssetLoaderRouterInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import Foundation

protocol AssetLoaderRouterInput {
    var transitionHandler: RamblerViperModuleTransitionHandlerProtocol! { get set }
}
