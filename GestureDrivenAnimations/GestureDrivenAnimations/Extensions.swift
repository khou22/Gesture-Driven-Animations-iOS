//
//  Extensions.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 7/5/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        var hexColor = hexString
        
        if hexString.hasPrefix("#") {
            hexColor.remove(at: hexString.startIndex)
            
            if hexColor.characters.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff) >> 8) / 255
                    a = CGFloat(1.0)
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
