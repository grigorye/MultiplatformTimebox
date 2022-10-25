@testable import TimeboxViews
import TimeboxData
import SwiftUI

struct ManuallyReorderableItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                ManuallyReorderableItemRow(item: .constant(fakeItemData[0]), delegate: FakeManuallyReorderableItemRowDelegate()) {
                    Text("1")
                }
                ManuallyReorderableItemRow(item: .constant(fakeItemData[1]), delegate: FakeManuallyReorderableItemRowDelegate()) {
                    Text("2")
                }
            }
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

struct FakeManuallyReorderableItemRowDelegate: ManuallyReorderableItemRowDelegate {
    typealias VItem = FakeItem
    
    func save() throws {
    }
    
    func moveItems(from indices: IndexSet, to offset: Int) throws {
    }
    
    func delete(_ item: FakeItem) throws {
    }
}
