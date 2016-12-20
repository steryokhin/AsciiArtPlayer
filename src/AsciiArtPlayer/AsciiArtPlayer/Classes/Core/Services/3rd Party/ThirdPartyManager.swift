//
//  ThirdPartyManager.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import Foundation
import Watchdog
import QorumLogs


class ThirdPartyManager : ThirdPartyManagerProtocol {
    func configure() {
        self.setupWatchdog()
        self.setupLogging()
    }

    var watchdog: Watchdog?
    
    func setupWatchdog() {
        self.watchdog = Watchdog(threshold: 0.5, strictMode: false)
    }
    
    func setupLogging() {
        #if DEBUG
            //TODO: 1 and 3 ==> make constants
            QorumLogs.minimumLogLevelShown = 1
        #else
            QorumLogs.minimumLogLevelShown = 3
        #endif
        QorumLogs.enabled = true
        QorumLogs.test()
    }
}
