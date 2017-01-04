//
//  AssetLoaderAssetLoaderAssemblyContainer.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class AssetLoaderAssemblyContainer: AssemblyType {

	func assemble(container: Container) {
		container.register(AssetLoaderInteractor.self) { (r, presenter: AssetLoaderPresenter) in
			let interactor = AssetLoaderInteractor()
			interactor.output = presenter

			return interactor
		}

        container.register(AssetLoaderRouter.self) { (r, presenter: AssetLoaderPresenter) in
			let router = AssetLoaderRouter()

            router.transitionHandler = presenter.picker
            
			return router
		}

		container.register(AssetLoaderPresenter.self) { (r) in
			let presenter = AssetLoaderPresenter()
			presenter.interactor = r.resolve(AssetLoaderInteractor.self, argument: presenter)

			return presenter
            }.initCompleted { r, c in
                let presenter = c 
                presenter.picker = r.resolve(AssetLoaderViewController.self)
                let myRouter = r.resolve(AssetLoaderRouter.self, argument: presenter)
                presenter.router = myRouter
                presenter.picker.moduleInput = presenter
        }
        
        container.register(AssetLoaderTransitionFactory.self) { (r) in
            let factory = AssetLoaderTransitionFactory()
            
            factory.picker = r.resolve(AssetLoaderViewController.self)
            
            return factory
        }
        
        container.register(AssetLoaderViewController.self) { (r) in
            let picker = AssetLoaderViewController()
            
            picker.moduleInput = r.resolve(AssetLoaderPresenter.self)
            
            return picker
        }

	}

}
