//
//  PlayerPlayerAssemblyContainer.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class PlayerAssemblyContainer: AssemblyType, SwinjectAutoloaderProtocol {
	
	func assemble(container: Container) {
		container.register(PlayerInteractor.self) { (r, presenter: PlayerPresenter) in
			let interactor = PlayerInteractor()
			interactor.output = presenter
			
			return interactor
		}
		
		container.register(PlayerRouter.self) { (r, viewController: PlayerViewController) in
			let router = PlayerRouter()
			router.transitionHandler = viewController
			
			return router
		}
		
		container.register(PlayerPresenter.self) { (r, viewController: PlayerViewController) in
			let presenter = PlayerPresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(PlayerInteractor.self, argument: presenter)
			presenter.router = r.resolve(PlayerRouter.self, argument: viewController)
			
			return presenter
		}
		
		container.registerForStoryboard(PlayerViewController.self) { r, viewController in
			viewController.output = r.resolve(PlayerPresenter.self, argument: viewController)
		}
	}
	
}
