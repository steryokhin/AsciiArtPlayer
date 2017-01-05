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

    weak var view: PlayerViewInput!
    var interactor: PlayerInteractorInput!
    var router: PlayerRouterInput!
    
    var output: PlayerModuleOutput?
    func setModuleOutput(_ moduleOutput: RamblerViperModuleOutput!) {
        self.output = moduleOutput as! PlayerModuleOutput?
    }
    
    var service: VideoFrameProviderServiceProtocol?

    ///MARK : PlayerViewOutput
    func viewIsReady() {
        QL2("PlayerPresenter: view is ready")
        
        self.view.setupInitialState()        
    }
    
    /// MARK: PlayerInteractorOutput
    func interactorConfigured(withService service: VideoFrameProviderServiceProtocol) {
        service.delegate = self
        self.service = service
        
        self.displayFrame(withTime: 0.0)
    }
    
    /// PlayerModuleInput
    func configure(withAVAsset avAsset: AVAsset) {
        self.interactor.configure(withAVAsset: avAsset)
    }
    
    
    func displayFrame(withTime time: CGFloat) {
        guard let myService = self.service else {
            return
        }
        
        print("display frame with time: \(time)")
        

        myService.frameWithTime(time: time)
    }
}

extension PlayerPresenter: VideoFrameProviderServiceDelegate {
    func frameComplete(withString asciiString: String, forTime time: CGFloat) {
        weak var weakSelf = self
        DispatchQueue.main.async {
            if let strongSelf = weakSelf {
                guard let myService = strongSelf.service else {
                    return
                }

                strongSelf.view.displayText(asciiString, font: myService.configuration.labelFont)
                strongSelf.displayFrame(withTime: time + 0.1)
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
