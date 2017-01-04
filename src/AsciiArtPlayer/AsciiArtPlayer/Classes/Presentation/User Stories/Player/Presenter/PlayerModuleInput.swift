//
//  PlayerPlayerModuleInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry

protocol PlayerModuleInput: class, RamblerViperModuleInput {
    func configure(withURL url: URL)
}
