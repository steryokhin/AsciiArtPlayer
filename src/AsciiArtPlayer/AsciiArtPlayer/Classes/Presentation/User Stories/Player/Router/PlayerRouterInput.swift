//
//  PlayerPlayerRouterInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import Foundation

protocol PlayerRouterInput {
    var transitionHandler: RamblerViperModuleTransitionHandlerProtocol? { get set }
}
