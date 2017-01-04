//
//  HomeHomeRouter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import QorumLogs
import Swinject
import UIKit
import ViperMcFlurry

class HomeRouter: NSObject, HomeRouterInput {
    fileprivate let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    fileprivate let segueIdentifier = "ShowPlayer"
    fileprivate let moduleID = "PlayerViewControllerID"

    var transitionHandler: RamblerViperModuleTransitionHandlerProtocol!

    /// Player with local file
    var moduleFactory: RamblerViperModuleFactory {
        let factory = RamblerViperModuleFactory(storyboard: mainStoryBoard, andRestorationId: moduleID)

        return factory!
    }
    
    func showPlayer(delegate: RamblerViperModuleOutput?, url: URL) {
        self.transitionHandler.openModule!(usingFactory: moduleFactory) { sourceModuleTransitionHandler, destinationModuleTransitionHandler in
            let sourceVC = sourceModuleTransitionHandler as! UIViewController
            let destinationVC = destinationModuleTransitionHandler as! UIViewController
            sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
            
            }.thenChain { moduleInput in
                guard let myModuleInput = moduleInput as? PlayerModuleInput else {
                    fatalError("invalid module type")
                }
                
                myModuleInput.configure(withURL: url)
                
                return delegate
        }
    }
    
    ///MARK: Asset Picker
    var assetModuleFactory: AssetLoaderTransitionFactory {
        let factory = ApplicationAssembly.assembler.resolver.resolve(AssetLoaderTransitionFactory.self)
        
        return factory!
    }

    func showAssetLoader(delegate: RamblerViperModuleOutput?) {
        self.transitionHandler.openModule!(usingFactory: assetModuleFactory) { sourceModuleTransitionHandler, destinationModuleTransitionHandler in
            let sourceVC = sourceModuleTransitionHandler as! UIViewController
            let destinationVC = destinationModuleTransitionHandler as! UIViewController
            sourceVC.present(destinationVC, animated: true, completion: nil)

        }.thenChain { moduleInput in
            guard let myModuleInput = moduleInput as? AssetLoaderModuleInput else {
                fatalError("invalid module type")
            }

            myModuleInput.configureVideoPicker()

            return delegate
        }
    }
    
    func showCameraRecorder(delegate: RamblerViperModuleOutput?) {
        
    }
    
}
