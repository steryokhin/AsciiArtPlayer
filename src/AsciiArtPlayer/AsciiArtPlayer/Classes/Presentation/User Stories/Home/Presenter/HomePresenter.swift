//
//  HomeHomePresenter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import QorumLogs
import AVFoundation

class HomePresenter: NSObject, HomeModuleInput, HomeViewOutput, HomeInteractorOutput {

    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!

    func viewIsReady() {
        QL2("Home module is ready")
    }
    
    func viewShowAssetLoader() {
        self.router.showAssetLoader(delegate: self)
    }
    
    func viewShowCameraRecorder() {
        self.router.showCameraRecorder(delegate: self)
    }
}

extension HomePresenter : AssetLoaderModuleOutput {
    func cancelAssetLoader(module: RamblerViperModuleTransitionHandlerProtocol) {
        module.closeCurrentModule!(true)
    }
    
    func completeAssetLoader(module: RamblerViperModuleTransitionHandlerProtocol, avAsset: AVAsset) {
        module.closeCurrentModule!(true)
        
        self.router.showPlayer(delegate: self, avAsset: avAsset)
    }
}

extension HomePresenter: PlayerModuleOutput {
    func cancelPlayer(module: RamblerViperModuleTransitionHandlerProtocol) {
        module.closeCurrentModule!(true)
    }
    
    func completePlayer(module: RamblerViperModuleTransitionHandlerProtocol) {
        module.closeCurrentModule!(true)
    }
}
