//
//  ParsingTimeInterval.swift
//  Timebox
//
//  Created by Grigory Entin on 04/07/2020.
//

import Foundation

public func timeIntervalFromString(_ timeString: String) -> TimeInterval {
    
    guard !timeString.isEmpty else {
        return 0
    }
    
    var timeInterval: TimeInterval = 0
    
    let parts = timeString.components(separatedBy: ":")
    
    for (index, part) in parts.reversed().enumerated() {
        timeInterval += (Double(part) ?? 0) * pow(Double(60), Double(index))
    }

    return timeInterval
}

public func stringFromTimeInterval(_ timeInterval: TimeInterval) -> String {
    dateComponentsFormatter.string(from: timeInterval)!
}

private let dateComponentsFormatter = DateComponentsFormatter()
