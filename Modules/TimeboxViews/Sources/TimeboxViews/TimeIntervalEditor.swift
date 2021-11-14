import TimeboxData
import SwiftUI

struct TimeIntervalEditor : View/*, TimeIntervalFormatting*/ {
    
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

struct TimeIntervalEditor_Previews : PreviewProvider {
    
    private struct TimeIntervalEditorSample : View {
        @State private var timeInterval: TimeInterval = 70
        
        var body: some View {
            TimeIntervalEditor(timeInterval: $timeInterval)
        }
    }
    
    static var previews: some View {
        TimeIntervalEditorSample()
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
