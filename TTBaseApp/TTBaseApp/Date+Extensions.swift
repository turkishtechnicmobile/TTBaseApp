//
//  Date+Extensions.swift
//  NMBaseApp
//
//  Created by Nazif MASMANACI on 24.08.2021.
//  Copyright © 2021 Turkish Technic. All rights reserved.
//

import Foundation

public extension Date {
    
    func toString(format : TTBaseDateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func toStringGMT(format : TTBaseDateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func zeroSeconds() -> Date {

        let timeInterval = floor(self.timeIntervalSinceReferenceDate / 60.0) * 60.0
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    func mergeTime(hour:Int, minute:Int) -> Date? {
        
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 00, of: self)
    }
    
    func adding(minutes:Int) -> Date? {
        
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)
    }
    
    
    var hour: Int {
        let hour = Calendar.current.component(.hour, from: self)
        return hour
    }
    
    var hourGMT:Int {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.component(.hour, from: self)
    }
    
    var minute: Int {
        let minute = Calendar.current.component(.minute, from: self)
        return minute
    }
    
    var minuteGMT:Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.component(.minute, from: self)
    }
}
