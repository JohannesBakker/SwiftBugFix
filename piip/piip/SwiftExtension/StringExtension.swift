//
//  StringExtension.swift
//  piip
//
//  Created by Johannes on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//

import Foundation

extension String {
    
    func toNSData() -> NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    /**
     String length
     */
    var length: Int { return self.characters.count }
}
