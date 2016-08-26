//
//  PPWebScoketHelper.swift
//  piip
//
//  Created by Johannes on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation
import SwiftyJSON

class PPWebSocketHelper {
    
    static func createReqHeader(seq: Int, method: String, param: [AnyObject]) -> JSON {
        
        let header: JSON = ["seq" : seq, "method" : method, "params" : param]
        return header
    }
}