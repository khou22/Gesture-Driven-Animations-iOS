//
//  Registration.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 7/5/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import Foundation
import UIKit

class RegistrationPageOne: UIViewController {
    
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var EmailInput: UITextField!
    
    override func viewDidLoad() {
        
        NameInput.attributedPlaceholder = NSMutableAttributedString(string: "Name", attributes: [NSForegroundColorAttributeName: UIColor(hexString: "#222222")! ])
        EmailInput.attributedPlaceholder = NSMutableAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor(hexString: "#222222")! ])
    }
    
}



class RegistrationPageTwo: UIViewController {
    
    
}
