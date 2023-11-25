//
//  DataHelper.swift
//  Moonlighting
//
//  Created by Sonata Girl on 19.11.2023.
//

import Foundation

// MARK: - Helper methods

final class DateHelper {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    static func date(from string: String) -> Date? {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: string)
    }
    
    static func string(from date: Date, format: String) -> String {
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
