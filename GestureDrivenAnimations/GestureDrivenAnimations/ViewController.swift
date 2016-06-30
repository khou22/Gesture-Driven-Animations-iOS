//
//  ViewController.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 6/27/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("View did load")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlePan(_ recognizer : UIPanGestureRecognizer) {
        print("Panning")
        let translation = recognizer.translation(in: view)
        let translatedCenterX = translation.x
        let progress = translatedCenterX / 200
        print(progress)

    }
}

