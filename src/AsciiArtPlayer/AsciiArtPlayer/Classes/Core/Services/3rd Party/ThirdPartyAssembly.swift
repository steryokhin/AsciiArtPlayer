//
//  ThirdPartyAssembly.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import Swinject
import Foundation

class ThirdPartyAssembly: AssemblyType, SwinjectAutoloaderProtocol {
    func assemble(container: Container) {
        container.register(ThirdPartyManagerProtocol.self) { _ in
            ThirdPartyManager()
        }
    }
}
