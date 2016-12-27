//
//  PlayerPlayerContainerTests.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import XCTest

class PlayerModuleConfiguratorTests: XCTestCase {

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
        let viewController = PlayerViewControllerMock()
        let configurator = PlayerModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "PlayerViewController is nil after configuration")
        XCTAssertTrue(viewController.output is PlayerPresenter, "output is not PlayerPresenter")

        let presenter: PlayerPresenter = viewController.output as! PlayerPresenter
        XCTAssertNotNil(presenter.view, "view in PlayerPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in PlayerPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is PlayerRouter, "router is not PlayerRouter")

        let interactor: PlayerInteractor = presenter.interactor as! PlayerInteractor
        XCTAssertNotNil(interactor.output, "output in PlayerInteractor is nil after configuration")
    }

    class PlayerViewControllerMock: PlayerViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
