//
//  PPRemoteNotificationManager.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

class PPRemoteNotificationManager: NSObject {
    
    static var sharedManager = PPRemoteNotificationManager()
    private var registrationOptions = [String: NSObject]()
    
    func registerRemoteNotification() {
        let types: UIUserNotificationType = [.Badge, .Sound, .Alert]
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    var tokenRegistrationHandler: GGLInstanceIDTokenHandler = { (token: String!, error: NSError!) -> Void in
        
        // Report GCM token to backend
        
    }
    
    // Even Delegate 
    func didRegisterForRemoteNotificationsWithDeviceToken(token: NSData) {
        
        // Token string
//        let rawTokenStr: NSString = token.description
//        let tokenStr: String = rawTokenStr.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
//        print("Token string = \(tokenStr)")
        
        // Indicates current sandbox Option
        self.registrationOptions = [kGGLInstanceIDRegisterAPNSOption: token, kGGLInstanceIDAPNSServerTypeSandboxOption: true]
        
        // Google Instance ID
        let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
        instanceIDConfig.delegate = self
        
        // Cloud messagins
        GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(PPConstants.GCM_SENDER_ID,
                                                                 scope: kGGLInstanceIDScopeGCM,
                                                                 options: self.registrationOptions,
                                                                 handler: self.tokenRegistrationHandler)
    }
    
    func didFailToRegisterForRemoteNotificationsWithError(error: NSError) {
        print(">>>>>>>> Failed to register remote notification: \(error)")
    }
    
    func didReceiveLocalNotification(notification: UILocalNotification) {
        print("\(notification)")
    }
    
    func didReceiveRemoteNotification(userInfo: [NSObject : AnyObject]) {
        print("\(userInfo)")
    }
}

extension PPRemoteNotificationManager : GGLInstanceIDDelegate {
    
    @objc func onTokenRefresh() {
        
        print("GCM token refresh")
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(PPConstants.GCM_SENDER_ID,
                                                                 scope: kGGLInstanceIDScopeGCM,
                                                                 options: self.registrationOptions,
                                                                 handler: self.tokenRegistrationHandler)
    }
}