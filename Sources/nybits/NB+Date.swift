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
    var endOfDay: Date { calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)! }
    
    @inlinable
    var startOfHour: Date { calendar.date(bySettingHour: self.hour, minute: 0, second: 0, of: self)! }
    @inlinable
    var endOfHour: Date { calendar.date(bySettingHour: self.hour, minute: 59, second: 59, of: self)! }
    
    @inlinable
    func adding(seconds: Int = 0, hours: Int = 0) -> Date { .init(timeInterval: TimeInterval(seconds) + TimeInterval(hours) * 3600, since: self) }
    
    @inlinable
    func adding(days: Int = 0, months: Int = 0) -> Date { calendar.date(byAdding: .month, value: months, to: calendar.date(byAdding: .day, value: days, to: self)!)! }
    
    @inlinable
    static var startOfToday: Date { Date().startOfDay }
    @inlinable
    static var endOfToday: Date { Date().endOfDay }
}
