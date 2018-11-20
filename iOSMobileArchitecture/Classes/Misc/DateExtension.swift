//
//  DateExtension.swift
//  RetNavigator
//
//  Created by Yegor on 08.10.2018.
//  Copyright © 2018 Andrey Chernyshev. All rights reserved.
//

import Foundation

extension Date {
    var minuteAndSeconds: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.string(from: self)
    }
    
    var hourAndMinutes: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.string(from: self)
    }
    
    var dayMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.string(from: self)
    }
}

extension TimeInterval {
    var minuteAndSeconds: String {
        let date = Date(timeIntervalSince1970: self)
        return date.minuteAndSeconds
    }
    
    var hourAndMinutes: String {
        let date = Date(timeIntervalSince1970: self)
        return date.hourAndMinutes
    }
    
    var dayMonthYear: String {
        let date = Date(timeIntervalSince1970: self)
        return date.dayMonthYear
    }
}

