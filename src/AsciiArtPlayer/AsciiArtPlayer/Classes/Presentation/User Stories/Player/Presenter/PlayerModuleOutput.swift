//
//  PlayerModuleOutput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 03/01/2017.
//  Copyright © 2017 iMacDev. All rights reserved.
//

import ViperMcFlurry

protocol PlayerModuleOutput: class, RamblerViperModuleOutput {
    func cancelPlayer(module: RamblerViperModuleTransitionHandlerProtocol)
    
    func completePlayer(module: RamblerViperModuleTransitionHandlerProtocol)
}

