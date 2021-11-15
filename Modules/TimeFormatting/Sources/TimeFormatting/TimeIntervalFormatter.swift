//
//  Created by Grigory Entin on 04/07/2020.
//

import Foundation

public protocol TimeIntervalFormatter {
    func stringFromTimeInterval(_ timeInterval: TimeInterval) -> String
    func timeIntervalFromString(_ string: String) -> TimeInterval
}

