//
//  UINavigationBarExtension.swift
//  piip
//
//  Created by Johannes on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func letCompletelyTransparent() {
        
        self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.shadowImage = UIImage()
        //        self.translucent = true
    }
    
    func letToNormal() {
        
        self.setBackgroundImage(nil, forBarMetrics: .Default)
        self.shadowImage = nil
        //        self.translucent = false
    }
}