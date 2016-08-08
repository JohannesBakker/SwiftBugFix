//
//  PPDigitsService.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation
import DigitsKit
import XCGLogger

class PPDigitsService: NSObject, DGTSessionUpdateDelegate {
    
    static let sharedInstance = PPDigitsService()
    private var log: XCGLogger = XCGLogger.defaultInstance()
    
    override init() {
        super.init()
        
        Digits.sharedInstance().sessionUpdateDelegate = self
    }
    
    func defaultConfiguration() -> DGTAuthenticationConfiguration {
        
        let configuration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
        
        let appearance = DGTAppearance()
        appearance.logoImage = UIImage(named: "PiipLogo")
        
        appearance.labelFont = UIFont(name: "HelveticaNeue-Bold", size: 16)
        appearance.bodyFont = UIFont(name: "HelveticaNeue-Italic", size: 16)
        
        appearance.accentColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.pp_mainTintColor()
        
        configuration.appearance = appearance
        
        return configuration
    }
    
    func authenticate(fromViewController: UIViewController?,
                             completionHandler: (providerKey: String?, oauthKey: String?, phoneNumber: String?, error: NSError?) -> Void) {
        
        log.debug("authenticate")
        
        Digits.sharedInstance().authenticateWithViewController(fromViewController, configuration: self.defaultConfiguration()) { (session, error) -> Void in
            if (session != nil) {
                
                let authConfig = Digits.sharedInstance().authConfig
                
                let oauthSigning = DGTOAuthSigning(authConfig: authConfig, authSession: session)
                let authHeaders = oauthSigning.OAuthEchoHeadersToVerifyCredentials()
                
                let provider = authHeaders[TWTROAuthEchoRequestURLStringKey] as? String
                let oauth = authHeaders[TWTROAuthEchoAuthorizationHeaderKey] as? String
                
                self.log.debug("updated session provider = \(provider)")
                self.log.debug("saved session token = \(oauth)")
                
                completionHandler(providerKey: provider, oauthKey: oauth, phoneNumber: session.phoneNumber, error: nil)
            }
            else {
                completionHandler(providerKey: nil, oauthKey: nil, phoneNumber: nil, error: error)
            }
            
        }
    }
    
    @objc func digitsSessionHasChanged(newSession: DGTSession!) {
        log.debug("session updated")
        
        let authConfig = Digits.sharedInstance().authConfig
        let oauthSigning = DGTOAuthSigning(authConfig: authConfig, authSession: newSession)
        let authHeaders = oauthSigning.OAuthEchoHeadersToVerifyCredentials()
        
        let provider = authHeaders[TWTROAuthEchoRequestURLStringKey] as? String
        let oauth = authHeaders[TWTROAuthEchoAuthorizationHeaderKey] as? String
        
        log.debug("updated session provider = \(provider!)")
        log.debug("updated session token = \(oauth!)")
    }
    
    @objc func digitsSessionExpiredForUserID(userID: String!) {
        log.debug("session expired")
        
    }
}