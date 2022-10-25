@testable import TimeboxViews
import SwiftUI

struct Knob_Previews: PreviewProvider {
    static var previews: some View {
        Knob {
            EmptyView()
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
