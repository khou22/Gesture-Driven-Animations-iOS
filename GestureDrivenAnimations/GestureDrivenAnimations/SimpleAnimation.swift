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
    
    var circleCenter: CGPoint!  // Create a circle view
    
    var circleAnimator: UIViewPropertyAnimator! // Declare circle animator
    var animationDuration = 4.0 // Standard animation duration
    
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
        
        // Add circle animation for expanding when being dragged
        circleAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut) // Don't initialize an action so that the breath animation doesn't kill itself after it finished
        
        // Add the circle to the view controller as a subview
        self.view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        // When the circle gets panned on
        
        let target = gesture.view!
        
        switch gesture.state {
        case .began, .ended:
            self.circleCenter = target.center // Return the circle to the center of view
            
            if circleAnimator.state == .active {
                // reset animator to inactive state
                circleAnimator.stopAnimation(true)
            }
            
            if (gesture.state == .began) {
                // Add the animation to the cue
                // Begin scaling circle
                circleAnimator.addAnimations({
                    target.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                })
            } else {
                circleAnimator.addAnimations({
                    target.transform = CGAffineTransform.identity
                })
            }
            
            if (circleAnimator.isRunning) { // If the circle is currently expanding (if someone has touched the circle and initiated the animation)
                
                // This 'if' statement just reverses the animation
                circleAnimator.pauseAnimation()
                
                // If the animation ended, reverse it and make the circle shrink back to normal
                circleAnimator.isReversed = gesture.state == .ended
            }
            circleAnimator.startAnimation()
            print("Starting animation")
            
            print("Animator isRunning, isReversed, state: \(circleAnimator.isRunning), \(circleAnimator.isReversed)") // Print key values
        case .changed:
            // If currently dragging
            let translation = gesture.translation(in: self.view) // Get pan translation
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y) // Apply translation
        default:
            break
        }
    }
}
