//
//  AssetLoaderAssetLoaderModuleInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry

enum AsciiMediaType: Int {
    case image
    case video
}

protocol AssetLoaderModuleInput: class, RamblerViperModuleInput {
    func configureVideoPicker()
    func configureImagePicker()
    func configureAllMediaPicker()
    
    func run()
}
