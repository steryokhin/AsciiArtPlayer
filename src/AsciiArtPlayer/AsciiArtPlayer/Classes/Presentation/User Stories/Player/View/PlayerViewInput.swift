//
//  PlayerPlayerViewInput.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit

protocol PlayerViewInput: class {

    /**
        @author Sergey Teryokhin
        Setup initial state of the view
    */

    func setupInitialState()
    
    func displayText(_ text: String, font: UIFont)
}
