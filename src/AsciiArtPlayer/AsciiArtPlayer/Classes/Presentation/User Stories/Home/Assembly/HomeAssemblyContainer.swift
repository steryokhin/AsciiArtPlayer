//
//  HomeHomeAssemblyContainer.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class HomeAssemblyContainer: AssemblyType, SwinjectAutoloaderProtocol {
	
	func assemble(container: Container) {
		container.register(HomeInteractor.self) { (r, presenter: HomePresenter) in
			let interactor = HomeInteractor()
			interactor.output = presenter
			
			return interactor
		}
		
		container.register(HomeRouter.self) { (r, viewController: HomeViewController) in
			let router = HomeRouter()
			router.transitionHandler = viewController
			
			return router
		}
		
		container.register(HomePresenter.self) { (r, viewController: HomeViewController) in
			let presenter = HomePresenter()
			presenter.view = viewController
			presenter.interactor = r.resolve(HomeInteractor.self, argument: presenter)
			presenter.router = r.resolve(HomeRouter.self, argument: viewController)
			
			return presenter
		}
		
		container.registerForStoryboard(HomeViewController.self) { r, viewController in
			viewController.output = r.resolve(HomePresenter.self, argument: viewController)
		}
	}
	
}
