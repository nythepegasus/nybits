//
//  NB+Date.swift
//  nybits
//
//  Created by ny on 8/22/24.
//

import Foundation

public extension Date {
    
    /// The current calendar used for date calculations.
    @inlinable
    var calendar: Calendar { Calendar.current }
    
    /// The current calendar used for date calculations.
    ///
    /// This is a static version of the `calendar` property, useful for date calculations at a type level.
    @inlinable
    static var calendar: Calendar { Calendar.current }
    
    /// The date components of the date instance relevant for notifications.
    ///
    /// Includes the `.second`, `.minute`, `.hour`, `.day`, `.month`, and `.year` components.
    @inlinable
    var notificationComponents: DateComponents { calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self) }
    
    // MARK: - Date Components
    
    /// The second component of the date.
    @inlinable
    var second: Int { calendar.component(.second, from: self) }
    
    /// The hour component of the date.
    @inlinable
    var hour: Int { calendar.component(.hour, from: self) }
    
    /// The minute component of the date.
    @inlinable
    var minute: Int { calendar.component(.minute, from: self) }
    
    /// The day component of the date.
    @inlinable
    var day: Int { calendar.component(.day, from: self) }
    
    /// The month component of the date.
    @inlinable
    var month: Int { calendar.component(.month, from: self) }
    
    /// The year component of the date.
    @inlinable
    var year: Int { calendar.component(.year, from: self) }
    
    /// The weekday component of the date.
    ///
    /// Returns the weekday number as an `Int`, where Sunday is 1 and Saturday is 7 (in the Gregorian calendar).
    @inlinable
    var weekday: Int { calendar.component(.weekday, from: self) }
    
    // MARK: - Start and End of Day
    
    /// The start of the day for the date instance.
    ///
    /// This returns the date at 00:00:00 on the same day.
    @inlinable
    var startOfDay: Date { calendar.startOfDay(for: self) }
    
    /// The end of the day for the date instance.
    ///
    /// This returns the date at 23:59:59 on the same day.
    @inlinable
    var endOfDay: Date { setting(seconds: 59, minutes: 59, hours: 23) }
    
    // MARK: - Start and End of Hour
    
    /// The start of the hour for the date instance.
    ///
    /// This returns the date with the minutes and seconds set to 00:00 for the same hour.
    @inlinable
    var startOfHour: Date { setting(seconds: 0, minutes: 0) }
    
    /// The end of the hour for the date instance.
    ///
    /// This returns the date with the minutes and seconds set to 59:59 for the same hour.
    @inlinable
    var endOfHour: Date { setting(seconds: 59, minutes: 59, hours: hour) }
    
    // MARK: - Setting Date Components
    
    /// Returns a date with the specified seconds set.
    ///
    /// If `seconds` is `nil`, the current seconds component is retained.
    @inlinable
    func setting(seconds: Int? = nil) -> Date {
        calendar.date(bySetting: .second, value: seconds ?? self.second, of: self)!
    }
    
    /// Returns a date with the specified minutes set.
    ///
    /// If `minutes` is `nil`, the current minutes component is retained.
    @inlinable
    func setting(minutes: Int? = nil) -> Date {
        calendar.date(bySetting: .minute, value: minutes ?? self.minute, of: self)!
    }
    
    /// Returns a date with the specified hours set.
    ///
    /// If `hours` is `nil`, the current hours component is retained.
    @inlinable
    func setting(hours: Int? = nil) -> Date {
        calendar.date(bySetting: .hour, value: hours ?? self.hour, of: self)!
    }
    
    /// Returns a date with the specified days set.
    ///
    /// If `days` is `nil`, the current day component is retained.
    @inlinable
    func setting(days: Int? = nil) -> Date {
        calendar.date(bySetting: .day, value: days ?? self.day, of: self)!
    }
    
    /// Returns a date with the specified months set.
    ///
    /// If `months` is `nil`, the current month component is retained.
    @inlinable
    func setting(months: Int? = nil) -> Date {
        calendar.date(bySetting: .month, value: months ?? self.month, of: self)!
    }
    
    /// Returns a date with the specified years set.
    ///
    /// If `years` is `nil`, the current year component is retained.
    @inlinable
    func setting(years: Int? = nil) -> Date {
        calendar.date(bySetting: .year, value: years ?? self.year, of: self)!
    }
    
    // MARK: - Adding Date Components
    
    /// Returns a new date by adding the specified number of seconds to the date.
    @inlinable
    func adding(seconds: Int = 0) -> Date {
        calendar.date(byAdding: .second, value: seconds, to: self)!
    }
    
    /// Returns a new date by adding the specified number of minutes to the date.
    @inlinable
    func adding(minutes: Int = 0) -> Date {
        calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    /// Returns a new date by adding the specified number of hours to the date.
    @inlinable
    func adding(hours: Int = 0) -> Date {
        calendar.date(byAdding: .hour, value: hours, to: self)!
    }
    
    /// Returns a new date by adding the specified number of days to the date.
    @inlinable
    func adding(days: Int = 0) -> Date {
        calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    /// Returns a new date by adding the specified number of months to the date.
    @inlinable
    func adding(months: Int = 0) -> Date {
        calendar.date(byAdding: .month, value: months, to: self)!
    }
    
    /// Returns a new date by adding the specified number of years to the date.
    @inlinable
    func adding(years: Int = 0) -> Date {
        calendar.date(byAdding: .year, value: years, to: self)!
    }
    
    /// Returns a new date by adding the specified combination of seconds, minutes, hours, days, months, and years to the date.
    @inlinable
    func adding(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        self.adding(seconds: seconds).adding(minutes: minutes).adding(hours: hours).adding(days: days).adding(months: months).adding(years: years)
    }
    
    /// Returns a new date by setting the specified combination of seconds, minutes, hours, days, months, and years.
    ///
    /// If any of the parameters are `nil`, the existing value for that component is retained.
    @inlinable
    func setting(seconds: Int? = nil, minutes: Int? = nil, hours: Int? = nil, days: Int? = nil, months: Int? = nil, years: Int? = nil) -> Date {
        self.setting(seconds: seconds).setting(minutes: minutes).setting(hours: hours).setting(days: days).setting(months: months).setting(years: years)
    }
    
    // MARK: - Custom Initializer
    
    /// Initializes a date with the specified time components.
    ///
    /// - Parameters:
    ///   - seconds: The seconds value. Defaults to 0.
    ///   - minutes: The minutes value. Defaults to 0.
    ///   - hours: The hours value. Defaults to 0.
    ///   - days: The number of days since January 1, 1970. Defaults to 0.
    ///   - months: The number of months since January 1, 1970. Defaults to 0.
    ///   - years: The number of years since January 1, 1970. Defaults to 0.
    init(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, months: Int = 0, years: Int = 0) {
        self = Date(timeIntervalSince1970: 0)
            .adding(seconds: seconds)
            .adding(minutes: minutes)
            .adding(hours: hours)
            .adding(days: days - 1)
            .adding(months: months - 1)
            .adding(years: years - 1970)
    }
    
    // MARK: - Static Properties for Today
    
    /// The start of the current day (00:00:00).
    @inlinable
    static var startOfToday: Date { Date().startOfDay }
    
    /// The end of the current day (23:59:59).
    @inlinable
    static var endOfToday: Date { Date().endOfDay }
}

#if !DISABLE_FOUNDATION_DEFAULTABLE
extension Date: Defaultable {
    public static var defaultValue: Date { Date() }
}
#endif
