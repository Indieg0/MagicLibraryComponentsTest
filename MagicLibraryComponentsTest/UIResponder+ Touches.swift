//
//  UIView + Touches.swift
//  RotateTogether
//
//  Created by Indieg0 on 16.06.17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import UIKit
import AssociatedValues

extension UIResponder {
    
    //Associated properties, because we can't create properties inside extensions/categories
    
    var lastTouch: CGPoint {
        get {
            return getAssociatedValue(key: "lastTouch", object: self, initialValue: CGPoint())
        }
        set {
            set(associatedValue: newValue, key: "lastTouch", object: self)
        }
    }
    
    var touchStartTime: TimeInterval {
        get {
            return getAssociatedValue(key: "touchStartTime", object: self, initialValue: TimeInterval())
        }
        set {
            set(associatedValue: newValue, key: "touchStartTime", object: self)
        }
    }
    
    var touchEndTime: TimeInterval {
        get {
            return getAssociatedValue(key: "touchEndTime", object: self, initialValue: TimeInterval())
        }
        set {
            set(associatedValue: newValue, key: "touchEndTime", object: self)
        }
    }

    open override class func initialize() {
        touchesBeganExchange()
        touchesEndedExchange()
    }
    
    //MARK: - Exchange Implementation Methods
   
    static func touchesBeganExchange() {
        exchangeOriginalMethod(originalSelector: #selector(touchesBegan(_:with:)), to: #selector(swizzle_touchesBegan(_:with:)), forClass: self, and: "touchesBegan")
    }
    
    static func touchesEndedExchange() {
        exchangeOriginalMethod(originalSelector: #selector(touchesEnded(_:with:)), to: #selector(swizzle_touchesEnded(_:with:)), forClass: self, and: "touchesEnded")
    }
    
    //MARK: - Method Swizzling
    
    func swizzle_touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swizzle_touchesBegan(touches, with: event)
        if let touch = touches.first{
            if let selfView = self as? UIView {
                let point = touch.location(in: selfView)
                lastTouch = point
                print("\(point)")
                print(selfView.findElementByPositionInView(x: Double(point.x), y: Double(point.y), view: selfView))
                touchStartTime = (event?.timestamp)!
            }
        }
    }
    
     func swizzle_touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        swizzle_touchesEnded(touches, with: event)
        if let touch = touches.first{
            if let selfView = self as? UIView {
                let point = touch.location(in: selfView)
                print("\(point)")
                touchEndTime = (event?.timestamp)!
                print(selfView.findElementByPositionInView(x: Double(point.x), y: Double(point.y), view: selfView))
                CustomGestureRecognizer.recognizeGestureByStartPoint(startPoint: lastTouch, endPoint: point, and: touchEndTime - touchStartTime)
            }
        }
    }
    
    
}
