//
//  AbbreviatedTimeIntervalFormatter.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 16/10/2020.
//

import Foundation

public struct AbbreviatedTimeIntervalFormatter: TimeIntervalFormatter {
    
    public init() {}
    
    public func timeIntervalFromString(_ timeString: String) -> TimeInterval {
        
        guard !timeString.isEmpty else {
            return 0
        }
        
        let parts = timeString.components(separatedBy: " ")
        
        let timeInterval = parts.reduce(0, { $0 + timeIntervalForAbbreviatedPart($1) })
        
        return timeInterval
    }
    
    public func stringFromTimeInterval(_ timeInterval: TimeInterval) -> String {
        dateComponentsFormatter.string(from: timeInterval)!
    }
    
}

private let dateComponentsFormatter: DateComponentsFormatter = {
    let dateComponentsFormatter = DateComponentsFormatter()
    dateComponentsFormatter.allowedUnits = supportedUnitsAndTimeIntervals.reduce(NSCalendar.Unit(), {[$0, $1.unit]})
    dateComponentsFormatter.unitsStyle = .abbreviated
    return dateComponentsFormatter
}()

private var timeIntervalsByAbbreviation: [String : TimeInterval] = {
    [String : TimeInterval](uniqueKeysWithValues: supportedUnitsAndTimeIntervals.map {$0.ti}.map { ti in
        let string = dateComponentsFormatter.string(from: ti)!
        let (digits, abbreviation) = timeIntervalDigitsAndAbbreviationFromString(string)
        assert(digits == "1")
        return (abbreviation, ti)
    })
}()

func timeIntervalDigitsAndAbbreviationFromString(_ part: String) -> (String, String) {
    let regex = try! NSRegularExpression(pattern: "^(?<digits>[0-9]+)(?<abbreviation>.*)$", options: [])
    let matches = regex.matches(in: part, options: [], range: NSRange(location: 0, length: part.count))
    assert(matches.count == 1)
    let match = matches.first!
    let digits = part[Range(match.range(withName: "digits"))!]
    let abbreviation = part[Range(match.range(withName: "abbreviation"))!]
    return (digits, abbreviation)
}

private func timeIntervalForAbbreviatedPart(_ part: String) -> TimeInterval {
    
    let (digits, abbreviation) = timeIntervalDigitsAndAbbreviationFromString(part)

    let digitsTimeInterval = TimeInterval(digits)!
    let abbreviationTimeInterval = timeIntervalsByAbbreviation[abbreviation]!
    
    let timeInterval = digitsTimeInterval * abbreviationTimeInterval
    
    return timeInterval
}

private let supportedUnitsAndTimeIntervals: [(unit: NSCalendar.Unit, ti: TimeInterval)] = [
    (.second, 1),
    (.minute, 60),
    (.hour, 60 * 60),
    (.day, 60 * 60 * 24),
    (.weekOfMonth, 60 * 60 * 24 * 7)
]
