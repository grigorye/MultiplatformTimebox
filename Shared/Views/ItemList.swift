//
//  ItemList.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 25/06/2020.
//

import SwiftUI

protocol ItemListDelegate {
    func moveItems(from indices: IndexSet, to offset: Int) throws
    func deleteItems(at indices: IndexSet) throws
}

struct ItemList<VItem, Data, Delegate>: View
where
    VItem: Item,
    Data: RandomAccessCollection,
    Data.Element == VItem,
    Delegate: ItemListDelegate
{
    
    let items: Data
    
    init(
        items: Data,
        play: @escaping (VItem) -> Void = { _ in },
        pause: @escaping (VItem) -> Void = { _ in },
        delegate: Delegate?
    ) {
        self.items = items
        self.play = play
        self.pause = pause
        self.delegate = delegate
    }
    
    let pause: (VItem) -> Void
    let play: (VItem) -> Void
    let delegate: Delegate?
    
    var body: some View {
        reorderableItemList {
            ForEach(items) { (item) in
                ItemRow(
                    item: .constant(item),
                    hoveredView: {
                        if item.isPlaying {
                            PlayPauseView(kind: .constant(.pause), action: { pause(item) })
                        } else {
                            PlayPauseView(kind: .constant(.play), action: { play(item) })
                        }
                    }
                )
            }
        }
    }
    
    // MARK: - Reordering
    
    @State private var selectedItem: VItem?
    
    func reorderableItemList<Content: DynamicViewContent>(@ViewBuilder content: () -> Content) -> some View {
        List(selection: $selectedItem) {
            content()
                .onMove { (indices, offset) in
                    try! delegate?.moveItems(from: indices, to: offset)
                }
                .onDelete { (indices) in
                    try! delegate?.deleteItems(at: indices)
                }
        }
    }
}

struct FakeContentView : View {
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
    typealias VItem = FakeItem
    
    func moveItems(from indices: IndexSet, to offset: Int) throws {
    }
    
    func deleteItems(at indices: IndexSet) throws {
    }
}
