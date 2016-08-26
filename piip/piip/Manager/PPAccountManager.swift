//
//  PPAccountManager.swift
//  piip
//
//  Created by Johannes on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class PPAccountManager {
    
    static func saveUser(userID: Int, token: String) {
        
        KeychainWrapper.defaultKeychainWrapper().setInteger(userID, forKey: PPConstants.Account.keychainUserId)
        KeychainWrapper.defaultKeychainWrapper().setString(token, forKey: PPConstants.Account.keychainUserToken)
    }
}
