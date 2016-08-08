//
//  PPEnvironment.swift
//  piip
//
//  Created by jimmy on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPEnvironment {
    static var sharedInstance = PPEnvironment()
    
    static func apiURL() -> NSURL {
        return NSURL(string: "ws://st.piip.com:8010")!
    }
    
    static func appVersion() -> String {
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        return version
    }
}
