//
//  HomeHomeRouter.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import ViperMcFlurry

class HomeRouter: NSObject, HomeRouterInput {
    fileprivate let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    fileprivate let segueIdentifier = "ShowPlayer"
    fileprivate let moduleID = "PlayerViewControllerID"

    var transitionHandler: RamblerViperModuleTransitionHandlerProtocol!

    var moduleFactory: RamblerViperModuleFactory {
        let factory = RamblerViperModuleFactory(storyboard: mainStoryBoard, andRestorationId: moduleID)

        return factory!
    }

    //Open module use Segue
//    func showPlayer() {
//        transitionHandler.openModule!(usingSegue: segueIdentifier).thenChain { moduleInput in
//            guard let playerModuleInput = moduleInput as? PlayerModuleInput else {
//                fatalError("invalid module type")
//            }
//            
//            playerModuleInput.configure()
//            
//            return nil
//        }
//    }

    func showPlayer() {
        self.transitionHandler.openModule!(usingFactory: moduleFactory) { sourceModuleTransitionHandler, destinationModuleTransitionHandler in
            let sourceVC = sourceModuleTransitionHandler as! UIViewController
            let destinationVC = destinationModuleTransitionHandler as! UIViewController
            sourceVC.navigationController?.pushViewController(destinationVC, animated: true)

        }.thenChain { moduleInput in
            guard let myModuleInput = moduleInput as? PlayerModuleInput else {
                fatalError("invalid module type")
            }
            myModuleInput.configure()

            return nil
        }
    }
}
