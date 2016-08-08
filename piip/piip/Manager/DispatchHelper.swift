//
//  DispatchHelper.swift
//  piip
//
//  Created by jimmy on 7/3/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation

// http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift

func executeOnMainQueueWithDelay(delay: Double, closure: () -> Void) {
    let delayTime = dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
    )
    dispatch_after(
        delayTime,
        dispatch_get_main_queue(),
        closure)
}

func executeOnMainQueue(closure: () -> Void) {
    
    if NSThread.isMainThread() {
        closure()
    }
    else {
        dispatch_async(dispatch_get_main_queue(), closure)
    }
}