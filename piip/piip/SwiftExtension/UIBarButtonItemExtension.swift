//
//  UIBarButtonItemExtension.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//
import UIKit

extension UIBarButtonItem {
    
    static func pp_CustomBarButton(withTitle title: String) -> UIBarButtonItem {
        
        let button = UIBarButtonItem(title: title, style: .Plain, target: nil, action: nil)
        button.tintColor = UIColor.pp_mainTintColor()
        
        return button
    }
    
    static func pp_LeftBarBackButton(target: AnyObject?, selector: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem(image: UIImage(named: "back_nav"), style: .Plain, target: target, action: selector)
    }
    
    static func pp_CloseBarButton(target: AnyObject?, selector: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem(barButtonSystemItem: .Stop, target: target, action: selector)
    }
}
