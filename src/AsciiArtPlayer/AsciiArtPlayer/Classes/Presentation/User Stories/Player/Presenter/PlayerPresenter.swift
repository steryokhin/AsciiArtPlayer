//
//  PlayerPlayerPresenter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import QorumLogs
import Foundation
import AVFoundation

class PlayerPresenter: NSObject, PlayerModuleInput, PlayerViewOutput, PlayerInteractorOutput {
    /// link to our view
    weak var view: PlayerViewInput!
    var interactor: PlayerInteractorInput!
    var router: PlayerRouterInput!

    /// Output module support (if required)
    var output: PlayerModuleOutput?
    func setModuleOutput(_ moduleOutput: RamblerViperModuleOutput!) {
        self.output = moduleOutput as! PlayerModuleOutput?
    }

    /// service to provide frames
    var frameService: VideoFrameProviderServiceProtocol?
    /// service which play audio for corresponing video
    var audioService: VideoAudioPlayerServiceProtocol?

    ///MARK : PlayerViewOutput
    func viewIsReady() {
        QL2("PlayerPresenter: view is ready")
        
        self.view.setupInitialState()        
    }
    
    /// MARK: PlayerInteractorOutput
    func interactorConfigured(withFrameService frameService: VideoFrameProviderServiceProtocol,
                              withAudioService audioService: VideoAudioPlayerServiceProtocol) {
        frameService.delegate = self
        self.frameService = frameService

        audioService.delegate = self
        audioService.play()
        self.audioService = audioService
        
        self.displayFrame(withTime: CGFloat(audioService.currentTime()))
    }

    func interactorFailed() {
        //TODO: show popup + back
    }

    func cancelAction() {
        self.audioService = nil
        self.frameService = nil
        
        guard let myOutput = self.output else {
            return
        }

        guard let myHandler = self.router.transitionHandler else {
            return
        }

        myOutput.cancelPlayer(module: myHandler)
    }

    /// PlayerModuleInput
    func configure(withAVAsset avAsset: AVAsset) {
        self.interactor.configure(withAVAsset: avAsset)
    }
    
    
    func displayFrame(withTime time: CGFloat) {
        guard let myService = self.frameService else {
            return
        }

        myService.frameWithTime(time: time)
        print("display frame with time: \(time)")
    }
}

extension PlayerPresenter: VideoFrameProviderServiceDelegate {
    func frameComplete(withString asciiString: String, forTime time: CGFloat) {
        weak var weakSelf = self
        DispatchQueue.main.async {
            if let strongSelf = weakSelf {
                guard let myService = strongSelf.frameService else {
                    return
                }

                guard let myAudioService = strongSelf.audioService else {
                    return
                }

                strongSelf.view.displayText(asciiString, font: myService.configuration.labelFont)

                self.displayFrame(withTime: CGFloat(myAudioService .currentTime()))
                //strongSelf.displayFrame(withTime: time + 0.1)
            }
        }
    }

    func frameFailed(withError error: Error) {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            if let strongSelf = weakSelf {
                guard let myOutput = strongSelf.output else {
                    return
                }
                
                guard let myHandler = strongSelf.router.transitionHandler else {
                    return
                }
                
                myOutput.cancelPlayer(module: myHandler)
            }
        }
    }


}

extension PlayerPresenter: VideoAudioPlayerDelegateProtocol {
    func didFinish(withService: VideoAudioPlayerService, result: Bool) {
        QL3("VIDEO FINISHED")
        
        self.cancelAction()
    }
}
