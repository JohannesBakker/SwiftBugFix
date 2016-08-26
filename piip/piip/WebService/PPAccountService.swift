//
//  PPAccountService.swift
//  piip
//
//  Created by Johannes on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PPAccountService {
    
    func registerMobile(digits_provider: String,
                        digits_oauth: String,
                        phone_number: String,
                        user_type: Int,
                        app_version: Int,
                        completionHandler: (userID: Int?, token: String?, success: Bool) -> Void ) {
        
        // Parameter
        let param: [AnyObject] = [digits_provider,
                           digits_oauth,
                           phone_number,
                           user_type,
                           app_version]
        
        let header = PPWebSocketHelper.createReqHeader(0,
                                                       method: "registerMobile",
                                                       param: param)
        
        // Text Request
        PPWebSocketService.sharedInstance.createTextRequest(header) { (success, response) in
            
            if let response = response where success == true {
                let responseJSON = JSON(data: response, options: [])
                let _ = responseJSON["method"].stringValue
                
                if let param = responseJSON["params"].array {
                    let userID = param[0].intValue
                    let token = param[1].stringValue
                    
                    // Save keychain wrapper
                    PPAccountManager.saveUser(userID, token: token)
                    
                    // Completion
                    completionHandler(userID: userID, token: token, success: true)
                    return
                }
                
                completionHandler(userID: nil, token: nil, success: false)
            }
            else {
                
                completionHandler(userID: nil, token: nil, success: false)
            }
        }
    }
    
    func connect(gcm_token: String,
                 uid: String,
                 token: String,
                 userType: Int) {
        
        
    }
}