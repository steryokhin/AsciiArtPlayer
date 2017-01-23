//
//  PlayerPlayerViewController.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import QorumLogs
import AsyncDisplayKit
import UIKit
import SwiftyAttributes
import SnapKit

class PlayerViewController: UIViewController, PlayerViewInput {
    @IBOutlet var scrollView: UIScrollView!
    
    var displayNode: ASTextNode!
    var asciiArtString: NSAttributedString? {
        didSet {
            guard let myString = asciiArtString else {
                return
            }
            
            self.displayNode?.attributedString = myString
            
            self.displayNode?.view.frame.size = CGSize(width: myString.size().width + 2.0,
                                                       height: myString.size().height + 2.0)
            self.updateMinZoomScaleForSize(size: self.view.bounds.size)
        }
    }
    
	var output: PlayerViewOutput!
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        
		output.viewIsReady()
	}
	
	
	// MARK: PlayerViewInput
	func setupInitialState() {
        self.setupUI()        
	}
    

    //MARK: UI
    func setupUI() {
        let node = ASTextNode()
        let myAttributedString = NSAttributedString(string: "")
        
        node.attributedText = myAttributedString
        node.isUserInteractionEnabled = true
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.automaticallyAdjustsScrollViewInsets = false
        self.scrollView.addSubnode(node)
        node.view.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        node.backgroundColor = UIColor.white
        
        self.displayNode = node

        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "My Back", style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func displayText(_ text: String, font: UIFont) {
        let string = NSAttributedString(string: text)
        self.asciiArtString = string.withFont(font)
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        guard let calculatedSize = self.displayNode.attributedText?.size() else {
            return
        }
        
        let widthScale = size.width / calculatedSize.width
        let heightScale = size.height / calculatedSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = minScale*10
        scrollView.zoomScale = minScale
    }

    ///MARK: Action
    func backAction() {
        self.output.cancelAction()
    }
}

extension PlayerViewController: UIScrollViewDelegate {
    func viewForZooming(in: UIScrollView) -> UIView? {
        return displayNode.view
    }
}

