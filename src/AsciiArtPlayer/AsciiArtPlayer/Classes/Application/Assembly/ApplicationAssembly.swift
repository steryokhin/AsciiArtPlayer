//
//  ApplicationAssembly.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 19/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//


import Swinject
import SwinjectStoryboard
import Foundation

class ApplicationAssembly {
	class var assembler: Assembler {
        return try! Assembler(assemblies: [ThirdPartyAssembly(),
                          HomeAssemblyContainer(),
                          PlayerAssemblyContainer(),
                          AssetLoaderAssemblyContainer()])
	}
	
	var assembler: Assembler
	
	init(with assemblies: [AssemblyType]) {
        assembler = try! Assembler(assemblies: assemblies)
	}
}

extension SwinjectStoryboard {
	public static func setup() {
		defaultContainer = ApplicationAssembly.assembler.resolver as! Container
	}
	
}
