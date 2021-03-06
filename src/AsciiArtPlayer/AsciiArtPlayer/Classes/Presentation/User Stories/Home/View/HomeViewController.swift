//
//  HomeHomeViewController.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {
	
	var output: HomeViewOutput!
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
	}
	
	
	// MARK: HomeViewInput
	func setupInitialState() {
	}
    
    @IBAction func didTouchAssetLoader() {
        self.output.viewShowAssetLoader()
    }
    
    @IBAction func didTouchCameraRecorder() {
        self.output.viewShowCameraRecorder()
    }
}
