//
//  SimpleAnimation.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 7/1/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import Foundation
import UIKit

class SimpleAnimation: UIViewController {
    
    var circlCenter: CGPoint!  // Create a circle view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background info
        print("Simple animation screen loaded")
        print("Tutorial from: http://jamesonquave.com/blog/designing-animations-with-uiviewpropertyanimator-in-ios-10-and-swift-3/")
        
        // Add a draggable view
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)) // Create a rectangular view
        circle.center = self.view.center // Move to the center of the screen
        circle.layer.cornerRadius = circle.frame.height / 2 // Make rect a circle
        circle.backgroundColor = UIColor.green() // Green background color
        
        // Add pan gesture recognizer to the circle
        // Basically so that the circle "draggable"
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragCircle))) // Pass in dragCircle function as action function
        
        // Add the circle to the view controller as a subview
        self.view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        // When the circle gets panned on
        
        let target = gesture.view!
        
        switch gesture.state {
        case .began, .ended:
            self.circlCenter = target.center // Return the circle to the center of view
        case .changed:
            // If currently dragging
            let translation = gesture.translation(in: self.view) // Get pan translation
            target.center = CGPoint(x: circlCenter!.x + translation.x, y: circlCenter!.y + translation.y) // Apply translation
        default:
            break
        }
    }
    
    
}
