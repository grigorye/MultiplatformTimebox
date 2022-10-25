import TimeboxData
import TimeFormatting
import SwiftUI

struct TimeIntervalEditor : View, TimeIntervalFormatting {
    
    @Binding var timeInterval: TimeInterval
    
    @State private var timeIntervalString: String = ""

    var body: some View {
        SelectableTextField(
            text: $timeIntervalString,
            onCommit: {
                timeInterval = timeIntervalFromString(timeIntervalString)
            }
        )
        .onAppear {
            timeIntervalString = stringFromTimeInterval(timeInterval)
        }
        .multilineTextAlignment(.trailing)
    }
}
