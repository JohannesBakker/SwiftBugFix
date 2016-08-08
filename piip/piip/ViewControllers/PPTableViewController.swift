//
//  PPTableViewController.swift
//  piip
//
//  Created by jimmy on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapBack(sender: AnyObject?) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onTapDismiss(sender: AnyObject?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
