//
//  PlayerPlayerViewOutput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import Foundation

@objc protocol PlayerViewOutput {

    /**
        @author Sergey Teryokhin
        Notify presenter that view is ready
    */

    func viewIsReady()

    func cancelAction()
}
