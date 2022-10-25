@testable import TimeboxViews
import TimeboxData
import SwiftUI

struct ProgressOverlayView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Text("Foo")
                ProgressOverlayView(progress: .constant(0.3))
            }
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
