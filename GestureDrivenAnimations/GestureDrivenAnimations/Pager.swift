//
//  Pager.swift
//  GestureDrivenAnimations
//
//  Created by Breathometer on 6/30/16.
//  Copyright © 2016 KevinHou. All rights reserved.
//

import Foundation
import UIKit

struct PercentageScrolled {
    // Global variable for percentage scrolled
    static var value: Float = 0.0
}

class Pager: UIPageViewController {
    
    var colorChange: UIViewPropertyAnimator?
    
    func getPageOne() -> PageOne {
        return storyboard!.instantiateViewController(withIdentifier: "PageOne") as! PageOne
    }
    
    func getPageTwo() -> PageTwo {
        return storyboard!.instantiateViewController(withIdentifier: "PageTwo") as! PageTwo
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Pager appeared")
        setViewControllers([getPageOne()], direction: .forward, animated: false, completion: nil) // Set first page
        dataSource = self
        
        // Set animations
        self.view.backgroundColor = UIColor.black()
        colorChange = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations: { [weak self] in
            self?.view.backgroundColor = UIColor(red: 255.0/255.0, green: 80.0/255.0, blue: 43.0/255.0, alpha: 1.0)
            })
    }
    
    override func viewDidLoad() {
        // Scrolling progress - from: http://stackoverflow.com/questions/22577929/progress-of-uipageviewcontroller
        super.viewDidLoad()
        for subView in view.subviews {
            if subView is UIScrollView {
                (subView as! UIScrollView).delegate = self
            }
        }
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
    
    // ********* Sets up the page control dots *********
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // On the first dot when you first load the Pager
        // Swift automatically handles switching pages and updating the page control dots
        // Updates when setViewControllers is called
        return 0
    }
}

extension Pager: UIScrollViewDelegate {
    
    // Track the progress of the scroll between pages
    // http://stackoverflow.com/questions/22577929/progress-of-uipageviewcontroller
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        var percentComplete: CGFloat
        percentComplete = fabs(point.x - view.frame.size.width)/view.frame.size.width // Calc percentage complete
        print("Percent of Scroll Completed: \(percentComplete)") // Feedback
        PercentageScrolled.value = Float(percentComplete) // Update the value
        colorChange?.fractionComplete = percentComplete
    }
}
