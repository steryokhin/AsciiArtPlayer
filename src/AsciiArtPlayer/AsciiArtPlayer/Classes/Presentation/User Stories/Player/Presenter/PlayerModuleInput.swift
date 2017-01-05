//
//  PlayerPlayerModuleInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import AVFoundation
import ViperMcFlurry

protocol PlayerModuleInput: class, RamblerViperModuleInput {
    func configure(withAVAsset avAsset: AVAsset)
}
