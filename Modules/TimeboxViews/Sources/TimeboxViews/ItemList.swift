//
//  ItemList.swift
//  Timebox
//
//  Created by Grigorii Entin on 25/06/2020.
//

import TimeboxData
import SwiftUI

public protocol ItemListDelegate {
    associatedtype Item: Identifiable
    
    func moveItems(from indices: IndexSet, to offset: Int) throws
    func deleteItems(at indices: IndexSet) throws
    func deleteItems(withIDs: Set<Item.ID>) throws
}

struct ItemList<VItem, Data, Delegate> : View
where
    VItem: Item,
    Data: RandomAccessCollection,
    Data.Element == VItem,
    Delegate: ItemListDelegate,
    Delegate.Item == Data.Element
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
        let list = List(selection: $selectedItems) {
            ForEach(items) { (item) in
                let selected = selectedItems.contains(item.id)
                ItemRow(
                    item: .constant(item),
                    hoveredView: {
                        PlayPauseView(
                            kind: .constant(item.isPlaying ? .pause : .play),
                            action: { item.isPlaying ? pause(item) : play(item) }
                        )
                        .foregroundColor(selected ? nil : .accentColor)
                    }
                )
            }
            .onMove { (indices, offset) in
                try! delegate?.moveItems(from: indices, to: offset)
            }
            .onDelete { (indices) in
                try! delegate?.deleteItems(at: indices)
            }
        }
        
        #if os(macOS)
        let platformList = list
            .onDeleteCommand {
                try! delegate?.deleteItems(withIDs: selectedItems)
            }
        #else
        let platformList = list
        #endif
        
        return platformList
    }
    
    // MARK: - Reordering
    
    @State private var selectedItems = Set<VItem.ID>()
}

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
