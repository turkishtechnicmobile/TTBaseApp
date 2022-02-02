//
//  DateFormatManager.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 12.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol TTDateFormat {
    var timeZone: TimeZone? { get }
    var timeZoneTR: TimeZone? { get }
    var currentDate: Date { get }
    var calender: Calendar { get }
    var apiDateFormatter: DateFormatter { get }
    var dateComponentFormatter: DateComponentsFormatter { get }
    func format(date: Date, with option: TTBaseDateFormatType, timeZone formatType: TimeZoneFormat) -> String
    func formatDifference(from: Date, to: Date) -> String?
    func hours(from date: Date) -> Int?
    func minutes(from date: Date) -> Int?
    func dateBySetting(hour: Int?, minute: Int?, of date: Date) -> Date
    func dateByAdding(component: Calendar.Component, value: Int, to date: Date) -> Date
    func combine(date: Date, with time: Date) -> Date?
    func extractSecond(from date: Date, with components: Set<Calendar.Component>) -> Date
}

public extension TTDateFormat {
    func format(date: Date, with option: TTBaseDateFormatType = .onlyDate, timeZone formatType: TimeZoneFormat = .trax) -> String {
        return format(date: date, with: option, timeZone: formatType)
    }
    
    func extractSecond(from date: Date, with components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]) -> Date {
        return extractSecond(from: date, with: components)
    }
}

public class TTDateFormatManager: TTDateFormat {
    
    public static let shared = TTDateFormatManager()
    
    public let timeZone = TimeZone(secondsFromGMT: 0) // GTM +0:00
    public let timeZoneTR = TimeZone(secondsFromGMT: 60*60*3) // GTM +3:00
    
    public var currentDate: Date {
        return Date()
    }
    
    private let locale = Locale(identifier: "en_US_POSIX")
    private let localeTR = Locale(identifier: "tr_TR")

    public lazy var calender: Calendar = {
        var calender = Calendar.current
        calender.timeZone = timeZone ?? calender.timeZone
        calender.locale = locale
        return calender
    }()
    
    public lazy var apiDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TTBaseDateFormatType.api.rawValue
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter
    }()
    
    public let dateComponentFormatter: DateComponentsFormatter = {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.unitsStyle = .short // “9 hr, 41 min, 30 sec”
        dateComponentFormatter.allowedUnits = [.hour, .minute]
        return dateComponentFormatter
    }()
    
    /// Default format is onlyDate
    public func format(date: Date, with option: TTBaseDateFormatType = .onlyDate, timeZone formatType: TimeZoneFormat = .trax) -> String {
        let timeZoneValue = formatType == .trax ? timeZone : timeZoneTR
        let localeValue = formatType == .trax ? locale : localeTR
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = option.rawValue
        dateFormatter.timeZone = timeZoneValue
        dateFormatter.locale = localeValue
        return dateFormatter.string(from: date)
    }
    
    public func date(from dateStr: String, with option: String = TTBaseDateFormatType.dateAndTime.rawValue, timeZone formatType: TimeZoneFormat = .trax) -> (Date?) {
        let timeZoneValue = formatType == .trax ? timeZone : timeZoneTR
        let localeValue = formatType == .trax ? locale : localeTR
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = option
        dateFormatter.timeZone = timeZoneValue
        dateFormatter.locale = localeValue
        return dateFormatter.date(from: dateStr)
    }
    
    public func formatDifference(from: Date, to: Date) -> String? {
        return dateComponentFormatter.string(from: from, to: to)
    }
    
    public func hours(from date: Date) -> Int? {
        let components: Set<Calendar.Component> = [.hour]
        return calender.dateComponents(components, from: date).hour
    }
    
    public func minutes(from date: Date) -> Int? {
        let components: Set<Calendar.Component> = [.minute]
        return calender.dateComponents(components, from: date).minute
    }
    
    public func dateBySetting(hour: Int?, minute: Int?, of date: Date) -> Date {
        guard let hour = hour, let minute = minute else { return date }
        return calender.date(bySettingHour: hour, minute: minute, second: 0, of: date) ?? date
    }
    
    public func dateByAdding(component: Calendar.Component, value: Int, to date: Date) -> Date {
        return calender.date(byAdding: component, value: value, to: date) ?? date
    }
    
    public func combine(date: Date, with time: Date) -> Date? {
        var dateComponents = calender.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calender.dateComponents([.hour, .minute, .second], from: time)
        
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        dateComponents.second = timeComponents.second
        
        return calender.date(from: dateComponents)
    }
    
    public func extractSecond(from date: Date, with components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]) -> Date {
        let dateComponents = calender.dateComponents(components, from: date)
        return calender.date(from: dateComponents) ?? date
    }
}

//public enum FormatOption: String {
//    case api = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
//    case dateAndTime = "dd.MM.yyyy HH:mm"
//    case onlyDate = "dd.MM.yyyy"
//    case onlyTime = "HH:mm"
//    case dateAndTimeAndSecond = "dd MMM yyyy HH:mm:ss"
//}

public enum TimeZoneFormat {
    case trax // GMT 0 : Zulu
    case tr // GTM +3:00
}
