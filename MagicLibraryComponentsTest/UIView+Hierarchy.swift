//
//  UIView+Hierarchy.swift
//  RotateTogether
//
//  Created by Indieg0 on 13.06.17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func hierarchyInView(view: UIView){
        for subview in view.subviews {
            
            print(subview.description)
            
            if subview.subviews.count > 0 {
                hierarchyInView(view: subview)
            }
        }
    }
    
    func findElementByIDInView(identifier: String, view: UIView){
        for subview in view.subviews {
            if subview.accessibilityIdentifier == identifier {
                print ("Element is found \(subview)")
            } else if subview.subviews.count > 0 {
                print ("Getting deeper...")
                findElementByIDInView(identifier: identifier, view: subview)
            }
        }
    }
    
    func findElementByPositionInView(x: Double, y: Double, view: UIView) -> [UIView]{
        
        let point = CGPoint(x: x, y: y)
        var viewArray = [UIView]()
        
        for subview in view.subviews {
            if subview.frame.contains(point) {
                viewArray.append(subview)
            }
            
            if subview.subviews.count > 0 {
                viewArray += findElementByPositionInView(x: x, y: y, view: subview)
            }
        }
        
        return viewArray
        
    }
    
    func findLastElementInView(x: Double, y: Double, view: UIView) -> UIView{
        print ("The most top element at (\(x), \(y)) is \(findElementByPositionInView(x: x, y: y, view: view).last!) \n")
        return findElementByPositionInView(x: x, y: y, view: view).last!
    }
    
    func propertyNames() -> Array<String>{
        var results: Array<String> = [];
        
        var count: UInt32 = 0;
        let myClass: AnyClass = self.classForCoder;
        let properties = class_copyPropertyList(myClass, &count);
        
        for i in 0 ..< count {
            let property = properties?[Int(i)];
            
            let cname = property_getName(property);
            
            let name = String(cString: cname!)
            results.append(name);
        }
        
        free(properties);
        print ("Element has next properties: \(results) \n")
        
        return results;
    }
}
