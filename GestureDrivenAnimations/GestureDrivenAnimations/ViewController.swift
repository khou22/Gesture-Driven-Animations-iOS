//
//  ViewController.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 6/27/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import UIKit
import Interpolate

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    var opacityChange: Interpolate?
    var logoPosition: Interpolate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPan(_:)))
        view.addGestureRecognizer(pan)
        
        opacityChange = Interpolate(
            from: 1, to: 0, apply: { [weak self] (opacity) in
                self?.logoImage.alpha = opacity
            })
        logoPosition = Interpolate(from: 0, to: view.bounds.size.width, apply: { [weak self] (xPosition) in
            self?.logoImage.layer.position.x = xPosition
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        let translatedCenterX = translation.x
        let progress = translatedCenterX / 200
//        print(progress)
        opacityChange?.progress = progress
        logoPosition?.progress = progress
    }

}

