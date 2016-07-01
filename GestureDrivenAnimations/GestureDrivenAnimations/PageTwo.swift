//
//  PageTwo.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 6/30/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import Foundation
import UIKit

class PageTwo: UIViewController {
    // iPhone variables
    @IBOutlet weak var iPhoneFrame: UIImageView!
    @IBOutlet weak var iPhoneFrameBottomConstraint: NSLayoutConstraint!
    var iPhoneFrameAnimation: UIViewPropertyAnimator?
    
    @IBOutlet weak var iPhoneContent: UIImageView!
    var iPhoneContentAnimation: UIViewPropertyAnimator?
    
    override func viewDidAppear(_ animated: Bool) {
        print("Page two appeared")
        iPhoneFrameAnimation?.startAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {

    }
    
    
    override func viewDidLoad() {
        
        // Animations
        
        // Set starting points
        iPhoneFrame.transform = CGAffineTransform(translationX: 0, y: 400)
        iPhoneFrameAnimation = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut, animations: { [weak self] in
//            self?.view.layoutIfNeeded()
            self?.iPhoneFrame.transform = CGAffineTransform(translationX: 0, y: 0)
            })

        iPhoneContent.alpha = 0
        iPhoneFrameAnimation?.addAnimations({ [weak self] in
            self?.iPhoneContent.alpha = 1
            }, delayFactor: 2.0)
        
//        iPhoneContentAnimation = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: { [weak self] in
//            self?.iPhoneContent.alpha = 1
//        })
        
    }
    
    func update() {
        print("Value:", PercentageScrolled.value)
        let progress = iPhoneFrameAnimation?.fractionComplete
        print(progress)
        iPhoneFrameAnimation?.fractionComplete = CGFloat(progress!)
    }
}

