//
//  PlayerPlayerInteractor.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import Foundation

class PlayerInteractor: PlayerInteractorInput {

    weak var output: PlayerInteractorOutput!

    func configure(withURL url: URL) {
        DispatchQueue.global().async {
            let service = ASCIIVideoFrameProviderService(assetURL: url)
         
            DispatchQueue.main.async {
                self.output.interactorConfigured(withService: service)
            }
        }
    }
}
