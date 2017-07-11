//
//  NSObject + Extension.swift
//  RotateTogether
//
//  Created by Indieg0 on 13.06.17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    /*
     Helper method to provide simple and similar functionality to all inherited classed of NSObject, it passes original and swizzled selector, which we should exchange. Also it's needed to provide class and unique token for swizzling.
     */
    
    class func exchangeOriginalMethod(originalSelector : Selector,  to swizzledSelector: Selector, forClass:AnyClass!, and token: String) {
        
        DispatchQueue.once(token: token) {
            
            let originalMethod = class_getInstanceMethod(forClass , originalSelector)
            let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
            
            let didAddMethod = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
        
    }
}
