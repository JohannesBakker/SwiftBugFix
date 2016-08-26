//
//  PPWalkthrough3ViewController.swift
//  piip
//
//  Created by Johannes on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPWalkthrough3ViewController: PPWalkthroughBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // save accepted terms status
        PPStorageManager.sharedInstance.saveTermsAccepted(true)
    }
    
}
