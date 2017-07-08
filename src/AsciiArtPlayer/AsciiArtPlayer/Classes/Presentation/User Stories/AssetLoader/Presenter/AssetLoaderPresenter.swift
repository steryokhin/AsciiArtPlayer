//
//  AssetLoaderAssetLoaderPresenter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import DKImagePickerController
import ViperMcFlurry
import QorumLogs
import MobileCoreServices
import AVFoundation

@objc class AssetLoaderPresenter: NSObject, AssetLoaderModuleInput, AssetLoaderInteractorOutput {
    var interactor: AssetLoaderInteractorInput!
    var router: AssetLoaderRouterInput!

    var picker: AssetLoaderViewController!
    
    var moduleOutput: AssetLoaderModuleOutput?    
    func setModuleOutput(_ moduleOutput: RamblerViperModuleOutput!) {
        self.moduleOutput = moduleOutput as! AssetLoaderModuleOutput?
    }

    func configureVideoPicker() {
        self.picker.allowMultipleTypes = false
        self.picker.assetType = .allVideos
        self.picker.showsCancelButton = true
        self.picker.singleSelect = true
        self.picker.autoCloseOnSingleSelect = true
        
        self.picker.didSelectAssets = { (assets: [DKAsset]) in
            let dkAsset = assets.first
            
            guard let myModuleOutput = self.moduleOutput else {
                return
            }
            
            guard let myAsset = dkAsset else {
                myModuleOutput.cancelAssetLoader(module: self.router.transitionHandler)
                return
            }
            
            myAsset.fetchAVAssetWithCompleteBlock({ (asset, info) in                
                DispatchQueue.main.async {
                    guard let myAsset = asset else {
                        myModuleOutput.cancelAssetLoader(module: self.router.transitionHandler)
                        return
                    }
                    
                    myModuleOutput.completeAssetLoader(module: self.router.transitionHandler, avAsset: myAsset)
                }
            })
        }
    }
    
    func configureImagePicker() {
    }
    
    func configureAllMediaPicker() {
    }
    
    func run() {
        QL2("RUN")
    }
    
}

extension AssetLoaderPresenter: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        guard let myModuleOutput = self.moduleOutput else {
            return
        }
        
        myModuleOutput.cancelAssetLoader(module: self.router.transitionHandler)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let myModuleOutput = self.moduleOutput else {
            return
        }

        let url = info[UIImagePickerControllerReferenceURL] as! URL
        myModuleOutput.completeAssetLoader(module: self.router.transitionHandler, avAsset: AVAsset(url: url))
    }
}

extension AssetLoaderPresenter: UINavigationControllerDelegate {
    
}
