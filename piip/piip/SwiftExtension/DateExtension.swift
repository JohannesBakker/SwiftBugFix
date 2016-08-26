//
//  DateExtension.swift
//  piip
//
//  Created by Johannes on 7/2/16.
//  Copyright © 2016 Piip Mobile AG. All rights reserved.
//


import UIKit

extension NSDate {

    func getYearComponent() -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self).year
    }
    
    func getMonthComponent() -> Int {
        
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self).month
    }
    
    func getDayComponent() -> Int {
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self).day
    }
    
    func getMonthSymbol() -> String {
        
        let monthNumber = getMonthComponent()
        let df = NSDateFormatter()
        return df.monthSymbols[monthNumber - 1]
    }
    
    // Returns "yyyy-MM-dd" formatted string
    func getFormattedString() -> String {
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone.localTimeZone()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(self)
    }
    
    func getHumanReadableString() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.stringFromDate(self)
    }
    
    class func dateFromISOString(string: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.dateFromString(string)
    }
    
    static func dateFromString(dateString : String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.dateFromString(dateString)
    }
    
    func pp_dateByAddingYearInterval(years: Int) -> NSDate {

        let dateComponents = NSDateComponents()
        dateComponents.year = years
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    func pp_easyToReadTimeStr() -> String {
        let beginningOfTodayCompoments = NSCalendar.currentCalendar().components([.Era, .Year, .Month, .Day], fromDate: NSDate())
        let beginningOfToday = NSCalendar.currentCalendar().dateFromComponents(beginningOfTodayCompoments)
        
        // if the date is before "beginning of today" (i.e. in the past) then the components will be positive
        let components = NSCalendar.currentCalendar().components([.Era, .Year, .Month, .Day, .Second], fromDate: self, toDate: beginningOfToday!, options: [])
        // print("sec: \(components.second) day: \(components.day) month: \(components.month) year: \(components.year)")
        
        if components.day > 0 {
            return NSDateFormatter.localizedStringFromDate(self, dateStyle: .ShortStyle, timeStyle: .NoStyle)
        } else {
            if components.second > 0 {
                return "Yesterday"
            } else {
                return NSDateFormatter.localizedStringFromDate(self, dateStyle: .NoStyle, timeStyle: .ShortStyle)
            }
        }
    }
}
