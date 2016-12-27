//
//  PlayerPlayerPresenter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import QorumLogs
import Foundation

class PlayerPresenter: PlayerModuleInput, PlayerViewOutput, PlayerInteractorOutput {

    weak var view: PlayerViewInput!
    var interactor: PlayerInteractorInput!
    var router: PlayerRouterInput!
    
    var service: VideoFrameProviderServiceProtocol?

    ///MARK : PlayerViewOutput
    func viewIsReady() {
        QL2("PlayerPresenter: view is ready")
        
        self.view.setupInitialState()
        
        let path = Bundle.main.path(forResource: "1", ofType: "mp4")
        let url = URL(fileURLWithPath: path!)
        self.interactor.configure(withURL: url)
    }
    
    /// MARK: PlayerInteractorOutput
    func interactorConfigured(withService service: VideoFrameProviderServiceProtocol) {
        self.service = service
        
        self.displayFrame(withTime: 0.0)
    }
    
    /// PlayerModuleInput
    func configure() {
        //TODO: implement me
    }
    
    
    func displayFrame(withTime time: CGFloat) {
        guard let myService = self.service else {
            return
        }
        
        print("display frame with time: \(time)")
        
        weak var weakSelf = self
        myService.frameWithTime(time: time) { (asciiText, nextFrameTime) in
            DispatchQueue.main.async {
                guard let strongSelf = weakSelf else {
                    return
                }
                
                guard let myFont = strongSelf.service?.configuration.labelFont else {
                    return
                }
                
                strongSelf.view.displayText(asciiText, font: myFont)
                strongSelf.displayFrame(withTime: nextFrameTime)
            }
        }
    }
}
