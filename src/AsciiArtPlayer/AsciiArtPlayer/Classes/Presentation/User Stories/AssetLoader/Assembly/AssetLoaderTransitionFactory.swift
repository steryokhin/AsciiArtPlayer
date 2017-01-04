//
//  AssetLoaderTransitionFactory.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 28/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import ViperMcFlurry
import Foundation

@objc class AssetLoaderTransitionFactory: RamblerViperModuleFactory {
    var picker: AssetLoaderViewController!
    
    public override func instantiateModuleTransitionHandler() -> RamblerViperModuleTransitionHandlerProtocol? {
        return picker
    }
}
