//
//  PPJoinNavigatinController.swift
//  piip
//
//  Created by Johannes on 7/3/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPJoinNavigatinController: PPNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let termsAcceted = PPStorageManager.sharedInstance.getTermsAccepted()
        let rootView : UIViewController
        
        if termsAcceted == true {
            // change RootViewController with Profile ViewController
            rootView = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileVC")
        }
        else {
            rootView = self.storyboard!.instantiateViewControllerWithIdentifier("IntroVC")
        }
        
        self.viewControllers = [rootView]
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

}
