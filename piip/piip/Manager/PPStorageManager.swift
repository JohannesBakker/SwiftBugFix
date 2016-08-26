//
//  PPStorageManager.swift
//  piip
//
//  Created by Johannes on 7/3/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPStorageManager: NSObject {
    
    // Shared instance
    static let sharedInstance = PPStorageManager()
    
    // NSUserDefaultsKey
    private let TermsAccepted = "termsaccepted"
    
    override init() {
        super.init()
    }
    
    // MARK: - Terms Accepted
    func getTermsAccepted() -> Bool {
        
        if let accepted = NSUserDefaults.standardUserDefaults().objectForKey(TermsAccepted) as? Bool {
            return accepted
        }
        
        return false
    }
    
    func saveTermsAccepted( accept: Bool ) {
        
        NSUserDefaults.standardUserDefaults().setObject(accept, forKey: self.TermsAccepted)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

}
