@testable import TimeboxViews
import TimeboxData
import SwiftUI

struct ManuallyReorderableItemList_Previews: PreviewProvider {
    
    struct PreviewContentView : View {
        @State var items: [FakeItem] = fakeItemData
        
        var body: some View {
            ManuallyReorderableItemList(items: items, delegate: FakeManuallyReorderableItemRowDelegate())
        }
    }
    
    static var previews: some View {
        PreviewContentView()
    }
}
