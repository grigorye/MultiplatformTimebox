//
//  Created by Grigory Entin on 20/10/2020.
//

import Foundation

public protocol TimeIntervalFormatting {
    
    var timeIntervalFormatter: TimeIntervalFormatter { get }
}

extension TimeIntervalFormatting {
    
    public func stringFromTimeInterval(_ timeInterval: TimeInterval) -> String {
        timeIntervalFormatter.stringFromTimeInterval(timeInterval)
    }
    
    public func timeIntervalFromString(_ string: String) -> TimeInterval {
        timeIntervalFormatter.timeIntervalFromString(string)
    }
}
