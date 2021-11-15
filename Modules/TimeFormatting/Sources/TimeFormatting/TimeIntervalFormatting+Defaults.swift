//
//  Created by Grigory Entin on 20/10/2020.
//

extension TimeIntervalFormatting {
    
    public var timeIntervalFormatter: TimeIntervalFormatter {
        defaultTimeIntervalFormatter
    }
}

private let defaultTimeIntervalFormatter: TimeIntervalFormatter = AbbreviatedTimeIntervalFormatter()
