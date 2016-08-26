//
//  PPUIStyle.swift
//  piip
//
//  Created by Johannes on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

struct PPUIStyle {
    
    static func applyUIStyle(window: UIWindow?) {
        
        // main tint color for the whole app
        window?.tintColor = UIColor.pp_mainTintColor()
        
        self.navigationBarStyle()
    }
    
    private static func navigationBarStyle() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.pp_navigationBarColor()
        
        let backNavImage = UIImage(named: "back_nav")
        navigationBarAppearance.backIndicatorImage = backNavImage
        navigationBarAppearance.backIndicatorTransitionMaskImage = backNavImage
    }
}
