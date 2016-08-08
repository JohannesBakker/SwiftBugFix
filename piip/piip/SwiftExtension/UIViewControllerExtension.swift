//
//  UIViewControllerExtension.swift
//  piip
//
//  Created by jimmy on 7/1/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import UIKit

// MARK: - UIViewController extension

extension UIViewController {
    
    func showAlertWithTitle(
        title: String?,
        message: String?,
        yesCompletion: (() -> Void)? = nil,
        noCompletion: (() -> Void)? = nil)
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        if noCompletion != nil {
            let noAction = UIAlertAction(
                title: "Cancel",
                style: UIAlertActionStyle.Default,
                handler: { action in
                    noCompletion!()
            })
            alertVC.addAction(noAction)
        }
        
        let yesAction = UIAlertAction(
            title: "Ok",
            style: UIAlertActionStyle.Default,
            handler: { action in
                yesCompletion?()
        })
        alertVC.addAction(yesAction)
        
        executeOnMainQueue { () -> Void in
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String?,
                   message: String?,
                   yesSection: (yesCompletion: (() -> Void), yesTitle: String),
                   noSection: (noCompletion: (() -> Void), noTitle: String)? )
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        if let noSection = noSection {
            let noAction = UIAlertAction(
                title: noSection.noTitle,
                style: UIAlertActionStyle.Default,
                handler: { action in
                    noSection.noCompletion()
            })
            alertVC.addAction(noAction)
        }
        
        let yesAction = UIAlertAction(
            title: yesSection.yesTitle,
            style: UIAlertActionStyle.Default,
            handler: { action in
                yesSection.yesCompletion()
        })
        alertVC.addAction(yesAction)
        
        executeOnMainQueue { () -> Void in
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    func showAlertWithTextField(
        title: String?,
        message: String?,
        placeholderText: String?,
        yesCompletion: ((String) -> Void)? = nil,
        noCompletion: (() -> Void)? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        var textFieldObserver: NSObjectProtocol?
        
        let noAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.Default,
            handler: { action in
                noCompletion?()
                NSNotificationCenter.defaultCenter().removeObserver(textFieldObserver!)
            }
        )
        let yesAction = UIAlertAction(
            title: "Ok",
            style: UIAlertActionStyle.Default,
            handler: { action in
                if let textFields = alertController.textFields {
                    let textField = textFields[0]
                    yesCompletion?(textField.text!)
                }
                NSNotificationCenter.defaultCenter().removeObserver(textFieldObserver!)
            }
        )
        yesAction.enabled = false
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = placeholderText
            
            textFieldObserver = NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification,
                object: textField,
                queue: NSOperationQueue.mainQueue(),
                usingBlock: { (notification) -> Void in
                    yesAction.enabled = textField.text?.length > 0
                }
            )
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}