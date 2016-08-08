//
//  PPIntroViewController.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPIntroViewController: PPViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.letCompletelyTransparent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapTest(sender: AnyObject) {
        
        PPDigitsService.sharedInstance.authenticate(self) { (providerKey, oauthKey, phoneNumber, error) in
            
            if error == nil {
                PPAccountService().registerMobile(providerKey!, digits_oauth: oauthKey!, phone_number: phoneNumber!, user_type: 1, app_version: 1, completionHandler: { (userID, token, error) in
                    
                    
                })
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        
        // save terms acceted status
        PPStorageManager.sharedInstance.saveTermsAccepted(false)
    }

}
