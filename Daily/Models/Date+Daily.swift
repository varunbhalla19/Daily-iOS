//
//  Date+Daily.swift
//  Daily
//
//  Created by varunbhalla19 on 08/10/22.
//

import Foundation

extension Date {
    
    var dateTimeString: String {
        var timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self) {
            let formatString = NSLocalizedString("Today at %@", comment: "time format string")
            return String(format: formatString, timeText)
        } else {
            let formatString = NSLocalizedString("%@ at %@", comment: "date-time format string")
            let dateString = formatted(.dateTime.month(.abbreviated).day())
            return String(format: formatString, dateString, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return "Today"
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
    
}
