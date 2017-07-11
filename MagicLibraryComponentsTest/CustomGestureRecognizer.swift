//
//  CustomGestureRecognizer.swift
//  RotateTogether
//
//  Created by Indieg0 on 19.06.17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

enum GestureType {
    case LeftSwipe
    case RightSwipe
    case UpSwipe
    case DownSwipe
    case Tap
}

class CustomGestureRecognizer: NSObject {

    var startPoint: CGPoint?
    var endPoint: CGPoint?
    
    /*
     Method that returns gestureType basically on startPoint and endPoint of user's touch, also it passes gestureTime property in order to calculate velocity. Next methods are helper methods for recognizeGestureByStartPoint.
     */
    
    class func recognizeGestureByStartPoint(startPoint: CGPoint, endPoint: CGPoint, and gestureTime : TimeInterval) -> GestureType {
        
        var gestureType : GestureType
        let vectorDistance = vectorDistanceBetweenStartPoint(startPoint: startPoint, and: endPoint)
        let scalarDistance = scalarDistanceFromVectorDistances(width: vectorDistance.width, height: vectorDistance.height)
        let velocity = calculateVelocityForGestureUsing(gestureTime: gestureTime, and: scalarDistance)
        
        //Here we check if vector direction is on X or Y axis
        if (abs(vectorDistance.width) > abs(vectorDistance.height)) {
            
            if (vectorDistance.width < 0) {
                gestureType = .RightSwipe
            } else {
                gestureType = .LeftSwipe
            }
            
        } else {
            if (vectorDistance.height < 0) {
                gestureType = .DownSwipe
            } else {
               gestureType = .UpSwipe
            }
        }
        
        //In order to give little bit more offset for touch
        
        if scalarDistance <= 20.0 {
            gestureType = .Tap
        }
        
        print("Gesture Type: \(gestureType)")
        print("Vector Distance: \(vectorDistance)")
        print("Scalar Distance: \(scalarDistance)")
        print("Time Of Gesture: \(gestureTime)")
        print("Gesture's speed (velocity): \(velocity)")
        
        return gestureType
    }
    
    
    //MARK: - Helper Methods
    
    private class func vectorDistanceBetweenStartPoint(startPoint: CGPoint, and endPoint: CGPoint) -> (width: CGFloat, height: CGFloat){
        return (startPoint.x - endPoint.x, startPoint.y - endPoint.y)
    }
    
    private class func scalarDistanceFromVectorDistances(width: CGFloat, height: CGFloat) -> Double {
        return sqrt(pow(Double(width), 2.0) + pow(Double(height), 2.0))
    }
    
    private class func calculateVelocityForGestureUsing(gestureTime: TimeInterval, and scalarDistance: Double) -> Double {
        return scalarDistance/gestureTime
    }
    
}
