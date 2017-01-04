//
//  AssetLoaderAssetLoaderPresenter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry
import QorumLogs
import MobileCoreServices

@objc class AssetLoaderPresenter: NSObject, AssetLoaderModuleInput, AssetLoaderInteractorOutput {
    var interactor: AssetLoaderInteractorInput!
    var router: AssetLoaderRouterInput!

    var picker: UIImagePickerController!
    
    var moduleOutput: AssetLoaderModuleOutput?    
    func setModuleOutput(_ moduleOutput: RamblerViperModuleOutput!) {
        self.moduleOutput = moduleOutput as! AssetLoaderModuleOutput?
    }

    func configureVideoPicker() {
        self.picker.delegate = self;
        self.picker.sourceType = .photoLibrary
        self.picker.mediaTypes = [kUTTypeMovie as String]
    }
    
    func configureImagePicker() {
        self.picker.delegate = self;
        self.picker.sourceType = .photoLibrary
    }
    
    func configureAllMediaPicker() {
        self.picker.delegate = self;
        self.picker.sourceType = .photoLibrary
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
        myModuleOutput.completeAssetLoader(module: self.router.transitionHandler, url: url)
    }
}

extension AssetLoaderPresenter: UINavigationControllerDelegate {
    
}
