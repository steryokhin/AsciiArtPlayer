//
//  SwinjectAutoloaderHelper.swift
//  AsciiArtPlayer
//
//  Created by Sergey Teryokhin on 20/12/2016.
//  Copyright © 2016 iMacDev. All rights reserved.
//

import Swinject
import Foundation

//TODO: commented while there is issue with loading list of objects created by list of classes

//extension ApplicationAssembly {
//    private func getClassList() -> [AnyClass] {
//        let expectedClassCount = objc_getClassList(nil, 0)
//        let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
//        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(allClasses) // Huh? We should have gotten this for free.
//        let actualClassCount:Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
//        
//        var classes = [AnyClass]()
//        for i in 0 ..< actualClassCount {
//            if let currentClass: AnyClass = allClasses[Int(i)] {
//                classes.append(currentClass)
//            }
//        }
//        
//        allClasses.deallocate(capacity: Int(expectedClassCount))
//        
//        return classes
//    }
//    
//    
//    func getClassesImplementingProtocol(p: Protocol) -> [Any] {
//        let classes = self.getClassList()
//        var ret = [AnyClass]()
//        
//        for cls in classes {
//            if class_conformsToProtocol(cls, p) {
//                ret.append(cls)
//            }
//        }
//        return ret
//    }
//    
//    func getClassesImplementingSwinjectAutoloading() -> [Any] {
//        return self.getClassesImplementingProtocol(p: SwinjectAutoloaderProtocol.self)
//    }
//}
