@testable import TimeboxViews
import TimeboxData
import SwiftUI

private struct FakeContentView : View {
    @State var items: [FakeItem] = fakeItemData
    
    var body: some View {
        ItemList(items: items, delegate: FakeItemListDelegate())
    }
}

struct ItemList_Previews: PreviewProvider {
    
    static var previews: some View {
        FakeContentView()
    }
}

private struct FakeItemListDelegate: ItemListDelegate {
    typealias Item = FakeItem
    
    func moveItems(from indices: IndexSet, to offset: Int) throws {
    }
    
    func deleteItems(at indices: IndexSet) throws {
    }
    
    func deleteItems(withIDs: Set<Item.ID>) throws {
    }
}
