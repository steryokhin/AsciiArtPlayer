//
//  AssetLoaderAssetLoaderContainerTests.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 27/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import XCTest

class AssetLoaderModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = AssetLoaderViewControllerMock()
        let configurator = AssetLoaderModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "AssetLoaderViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AssetLoaderPresenter, "output is not AssetLoaderPresenter")

        let presenter: AssetLoaderPresenter = viewController.output as! AssetLoaderPresenter
        XCTAssertNotNil(presenter.view, "view in AssetLoaderPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AssetLoaderPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AssetLoaderRouter, "router is not AssetLoaderRouter")

        let interactor: AssetLoaderInteractor = presenter.interactor as! AssetLoaderInteractor
        XCTAssertNotNil(interactor.output, "output in AssetLoaderInteractor is nil after configuration")
    }

    class AssetLoaderViewControllerMock: AssetLoaderViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
