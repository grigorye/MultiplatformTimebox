@testable import TimeboxViews
import TimeboxData
import SwiftUI

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
