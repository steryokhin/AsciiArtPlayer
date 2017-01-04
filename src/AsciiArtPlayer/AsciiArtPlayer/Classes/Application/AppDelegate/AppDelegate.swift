//
//  AppDelegate.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 17/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var thirdParthyManager: ThirdPartyManagerProtocol! {
        return SwinjectStoryboard.defaultContainer.resolve(ThirdPartyManagerProtocol.self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        thirdParthyManager.configure()
        
        return true
    }
}

