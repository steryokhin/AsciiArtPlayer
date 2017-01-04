//
//  AssetLoaderAssetLoaderRouter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import ViperMcFlurry

class AssetLoaderRouter: NSObject, AssetLoaderRouterInput {
//fileprivate let mainStoryBoard = R.storyboard.main()
//fileprivate let segueIdentifier = "YourSegueID"
//fileprivate let moduleID = "YOURVIEWCONTROLLERID"

    var transitionHandler: RamblerViperModuleTransitionHandlerProtocol!

//var moduleFactory: RamblerViperModuleFactory {
//    let factory = RamblerViperModuleFactory(storyboard: mainStoryBoard, andRestorationId: moduleID)
//
//    return factory!
//}

//Open module use Segue
//    func showModule() {
//        transitionHandler.openModule!(usingSegue: segueIdentifier).thenChain { moduleInput in
//            guard let myModuleInput = moduleInput as? YOURModuleInput else {
//                fatalError("invalid module type")
//            }
//
//            myModuleInput.configure()
//
//            return nil
//        }
//    }

//func showPlayer() {
//    self.transitionHandler.openModule!(usingFactory: moduleFactory) { sourceModuleTransitionHandler, destinationModuleTransitionHandler in
//        let sourceVC = sourceModuleTransitionHandler as! UIViewController
//        let destinationVC = destinationModuleTransitionHandler as! UIViewController
//        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
//        }.thenChain { moduleInput in
//            guard let moduleInput = moduleInput as? YOURModuleInput else {
//                fatalError("invalid module type")
//            }
//            moduleInput.configure()
//
//            return nil
//    }
//}
}
