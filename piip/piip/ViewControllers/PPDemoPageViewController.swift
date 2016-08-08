//
//  PPDemoPageViewController.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPDemoPageViewController: PPViewController {

    private var pageViewController: UIPageViewController!
    private var contentViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create view controller
        let viewController1 = self.storyboard?.instantiateViewControllerWithIdentifier("Demo1") as! PPWalkthrough1ViewController
        viewController1.pageIndex = 0
        let viewController2 = self.storyboard?.instantiateViewControllerWithIdentifier("Demo2") as! PPWalkthrough2ViewController
        viewController2.pageIndex = 1
        let viewController3 = self.storyboard?.instantiateViewControllerWithIdentifier("Demo3") as! PPWalkthrough3ViewController
        viewController3.pageIndex = 2
        
        self.contentViewControllers.append(viewController1)
        self.contentViewControllers.append(viewController2)
        self.contentViewControllers.append(viewController3)
        
        // Page View Controller
        self.pageViewController = self.childViewControllers[0] as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        // Set initial view controller
        self.pageViewController.setViewControllers([viewController1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.pageViewController.didMoveToParentViewController(self)
        
        // transparent Navigation Bar
        self.navigationController?.navigationBar.letCompletelyTransparent()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onTapSkipNow(sender: UIBarButtonItem) {
        
        // save accepted terms status
        PPStorageManager.sharedInstance.saveTermsAccepted(true)

        let profileVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileVC") as! PPJoinProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }

}



extension PPDemoPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let currentView = viewController as! PPWalkthroughBasicViewController
        let currentIndex = currentView.pageIndex + 1
        
        if currentIndex >= self.contentViewControllers.count {
            return nil
        }
        
        return self.contentViewControllers[currentIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let currentView = viewController as! PPWalkthroughBasicViewController
        if currentView.pageIndex == 0 {
            return nil
        }
        
        let currentIndex = currentView.pageIndex - 1
        return self.contentViewControllers[currentIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return self.contentViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
}