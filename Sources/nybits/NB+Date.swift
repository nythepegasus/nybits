//
//  NB+Date.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

public extension Date {
    @inlinable
    var calendar: Calendar { Calendar.current }
    @inlinable
    static var calendar: Calendar { Calendar.current }
    
    @inlinable
    var notificationComponents: DateComponents { calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self) }
    
    @inlinable
    var second: Int { calendar.component(.second, from: self) }
    @inlinable
    var hour: Int { calendar.component(.hour, from: self) }
    @inlinable
    var minute: Int { calendar.component(.minute, from: self) }
    @inlinable
    var day: Int { calendar.component(.day, from: self) }
    @inlinable
    var month: Int { calendar.component(.month, from: self) }
    @inlinable
    var year: Int { calendar.component(.year, from: self) }
    @inlinable
    var weekday: Int { calendar.component(.weekday, from: self) }
    @inlinable
    var startOfDay: Date { calendar.startOfDay(for: self) }
    @inlinable
    var endOfDay: Date { setting(seconds: 59, minutes: 59, hours: 23) }
    
    @inlinable
    var startOfHour: Date { setting(seconds: 0, minutes: 0) }
    @inlinable
    var endOfHour: Date { setting(seconds: 59, minutes: 59, hours: 59) }
    
    @inlinable
    func setting(seconds: Int = 0) -> Date {
        calendar.date(bySetting: .second, value: seconds, of: self)!
    }
    
    @inlinable
    func setting(minutes: Int = 0) -> Date {
        calendar.date(bySetting: .minute, value: minutes, of: self)!
    }
    
    @inlinable
    func setting(hours: Int = 0) -> Date {
        calendar.date(bySetting: .hour, value: hours, of: self)!
    }
    
    @inlinable
    func setting(days: Int = 0) -> Date {
        calendar.date(bySetting: .day, value: days, of: self)!
    }
    
    @inlinable
    func setting(months: Int = 0) -> Date {
        calendar.date(bySetting: .month, value: months, of: self)!
    }
    
    @inlinable
    func setting(years: Int = 0) -> Date {
        calendar.date(bySetting: .year, value: years, of: self)!
    }
    
    @inlinable
    func adding(seconds: Int = 0) -> Date {
        calendar.date(byAdding: .second, value: seconds, to: self)!
    }
    
    @inlinable
    func adding(minutes: Int = 0) -> Date {
        calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    @inlinable
    func adding(hours: Int = 0) -> Date {
        calendar.date(byAdding: .hour, value: hours, to: self)!
    }
    
    @inlinable
    func adding(days: Int = 0) -> Date {
        calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    @inlinable
    func adding(months: Int = 0) -> Date {
        calendar.date(byAdding: .month, value: months, to: self)!
    }
    
    @inlinable
    func adding(years: Int = 0) -> Date {
        calendar.date(byAdding: .year, value: years, to: self)!
    }
    
    @inlinable
    func adding(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        self.adding(seconds: seconds).adding(minutes: minutes).adding(hours: hours).adding(months: months).adding(years: years)
    }
    
    @inlinable
    func setting(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        self.setting(seconds: seconds).setting(minutes: minutes).setting(hours: hours).setting(days: days).setting(months: months).setting(years: years)
    }
    
    init(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, months: Int = 0, years: Int = 0){
        self = Date(timeIntervalSince1970: 0).setting(seconds: seconds).setting(minutes: minutes).setting(hours: hours).setting(days: days).setting(months: months).setting(years: years)
    }

    @inlinable
    static var startOfToday: Date { Date().startOfDay }
    @inlinable
    static var endOfToday: Date { Date().endOfDay }
}
