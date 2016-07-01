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
    
    var backgroundColorAnimation: UIViewPropertyAnimator! // Declare background color animation
    
    var equilibriumBackground: UIColor? // Declare standard background
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        equilibriumBackground = UIColor(white: view.frame.height / 2, alpha: 1.0)
        
        // Set background color
        view.backgroundColor = UIColor.white()
        
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
        
        // Background animation for changing colors
        backgroundColorAnimation = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut, animations: {
            self.view.backgroundColor = UIColor.black()
        })
        
        // Add the circle to the view controller as a subview
        self.view.addSubview(circle)
        
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        // When the circle gets panned on
        
        let target = gesture.view! // Gesture's view (use to get the position of finger)
        
        switch gesture.state {
        case .began, .ended:
            self.circleCenter = target.center // Return the circle to the center of view
            
            let durationFactor = circleAnimator.fractionComplete // Multiplier for original duration — percent complete
            print("Breathing percentage complete:", durationFactor)
            // Multiplier for original duration that will be used for new duration
            circleAnimator.stopAnimation(false) // Stop animation
            circleAnimator.finishAnimation(at: .current) // Make current position its new static position
            
            if circleAnimator.state == .active {
                // reset animator to inactive state
                circleAnimator.stopAnimation(true)
            }
            
            if (gesture.state == .began) {
                // Set timing function
                let curveProvider = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.2, y: -0.48), controlPoint2: CGPoint(x: 0.79, y: 1.41)) // Create custom timing via bezier curve
                circleAnimator = UIViewPropertyAnimator(duration: animationDuration, timingParameters: curveProvider) // Apply properties
                
                // Add the animation to the cue
                // Begin scaling circle
                circleAnimator.addAnimations({
                    target.backgroundColor = UIColor.green()
                    target.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                })
            } else {
                circleAnimator.addAnimations({
                    target.backgroundColor = UIColor.green()
                    target.transform = CGAffineTransform.identity
                })
            }
            
            if (circleAnimator.isRunning) { // If the circle is currently expanding (if someone has touched the circle and initiated the animation)
                
                // This 'if' statement just reverses the animation
                circleAnimator.pauseAnimation()
                
                // If the animation ended, reverse it and make the circle shrink back to normal
                circleAnimator.isReversed = gesture.state == .ended
            }
            circleAnimator.startAnimation() // Start animation
            circleAnimator.pauseAnimation() // Pause so that we can set the duration factor
            circleAnimator.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor) // Apply duration factor
            // This ensures that the deflating animation time is the same as the amount of time it was inflating for
            
            print("Animator isRunning, isReversed, state: \(circleAnimator.isRunning), \(circleAnimator.isReversed)") // Print key values
            
            if (gesture.state == .ended) {
                let v = gesture.velocity(in: target)
                // 500 is an arbitrary value that looked pretty good, you may want to base this on device resolution or view size.
                // The y component of the velocity is usually ignored, but is used when animating the center of a view
                let velocity = CGVector(dx: v.x / 500, dy: v.y / 500) // Determine resultant velocity
                let springParameters = UISpringTimingParameters(mass: 2.5, stiffness: 70, damping: 55, initialVelocity: velocity) // Generate
                
                // Update timing
                circleAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters) // Set duration to 0.0 so its natural looking
                
                // Add new animation -> go back to center of page
                circleAnimator!.addAnimations({
                    target.center = self.view.center
                })
                circleAnimator.addCompletion({_ in 
                    // When animation complete
                    print("Returned to center")
                })
                
                backgroundColorAnimation = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters)
                backgroundColorAnimation.addAnimations({
                    self.equilibriumBackground = UIColor(white: 0.5, alpha: 1.0)
                    self.view.backgroundColor = self.equilibriumBackground
                })
                backgroundColorAnimation.startAnimation() // Reset background color
                backgroundColorAnimation.addCompletion({_ in
                    self.backgroundColorAnimation.stopAnimation(false) // Don't let it start on its own
                    self.backgroundColorAnimation = UIViewPropertyAnimator(duration: self.animationDuration, curve: .easeInOut, animations: {
                        self.view.backgroundColor = UIColor.black()
                    })
                })
                
                circleAnimator!.startAnimation()
            }
        case .changed:
            // If currently dragging
            let translation = gesture.translation(in: self.view) // Get pan translation
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y) // Apply translation
            
            // Change background color based on position of circle
            backgroundColorAnimation?.startAnimation()
            backgroundColorAnimation?.fractionComplete = target.center.y / self.view.frame.height
        default:
            break
        }
    }
}
