//
//  Pager.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 6/30/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import Foundation
import UIKit

class Pager: UIPageViewController {
    
    func getPageOne() -> PageOne {
        return storyboard!.instantiateViewController(withIdentifier: "PageOne") as! PageOne
    }
    
    func getPageTwo() -> PageTwo {
        return storyboard!.instantiateViewController(withIdentifier: "PageTwo") as! PageTwo
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Pager appeared")
        
        setViewControllers([getPageOne()], direction: .forward, animated: false, completion: nil)
        
        dataSource = self
        
        view.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)
    }
    
}

extension Pager: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Swiping forward
        if viewController is PageOne {
            // Return page two
            return getPageTwo()
        } else { // If on last page
            // End of all pages
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Swiping backward
        
        // Swiping forward
        if viewController is PageTwo {
            // Return page two
            return getPageOne()
        } else { // If on last page
            // End of all pages
            return nil
        }
    }
}
