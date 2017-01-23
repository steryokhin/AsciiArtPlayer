//
//  PlayerPlayerInteractor.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import QorumLogs
import AVFoundation
import Foundation

class PlayerInteractor: PlayerInteractorInput {

    weak var output: PlayerInteractorOutput!

    func configure(withAVAsset avAsset: AVAsset) {
        DispatchQueue.global().async {
            let service = ASCIIVideoFrameProviderService(avAsset: avAsset)

            guard let avURLAsset = avAsset as? AVURLAsset else {
                QL4("It is not avURLAsset object: \(avAsset)")
                self.output.interactorFailed()
                return
            }

            let audioService = try? VideoAudioPlayerService(withURL: avURLAsset.url)

            guard let myAudioService = audioService else {
                self.output.interactorFailed()
                return
            }
            DispatchQueue.main.async {
                self.output.interactorConfigured(withFrameService: service, withAudioService: myAudioService)
            }
        }
    }
}
