//
//  PPMainTabBarController.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setup tabBar controllers
        self.setupViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewControllers() {
        
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let chatView = chatStoryboard.instantiateInitialViewController()!
        
        let billboardStoryboard = UIStoryboard(name: "Billboard", bundle: nil)
        let billboardView = billboardStoryboard.instantiateInitialViewController()!
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchView = searchStoryboard.instantiateInitialViewController()!
        
        let profileStoryboard = UIStoryboard(name: "MyProfile", bundle: nil)
        let profileView = profileStoryboard.instantiateInitialViewController()!
    
        self.setViewControllers([chatView, billboardView, searchView, profileView], animated: true)
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
