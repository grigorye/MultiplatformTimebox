//
//  ManuallyReorderableItemList.swift
//  Timebox
//
//  Created by Grigory Entin on 06/07/2020.
//

import TimeboxData
import SwiftUI

struct ManuallyReorderableItemList<VItem, Data, Delegate> : View
where
    Data: RandomAccessCollection,
    Data.Element == VItem,
    Delegate: ManuallyReorderableItemRowDelegate,
    Delegate.VItem == VItem
{
    let items: Data
    
    init(
        items: Data,
        play: @escaping (VItem) throws -> Void = { _ in },
        pause: @escaping (VItem) throws -> Void = { _ in },
        delegate: Delegate?
    ) {
        self.items = items
        self.play = play
        self.pause = pause
        self.delegate = delegate
    }
    
    let pause: (VItem) throws -> Void
    let play: (VItem) throws -> Void
    let delegate: Delegate?
    
    var body: some View {
        reorderableItemList {
            ForEach(items) { (item) in
                ManuallyReorderableItemRow(item: .constant(item), delegate: delegate) {
                    ItemRow(item: .constant(item), hoveredView: {
                        if item.isPlaying {
                            PlayPauseView(kind: .constant(.pause), action: { try! pause(item) })
                        } else {
                            PlayPauseView(kind: .constant(.play), action: { try! play(item) })
                        }
                    })
                }.tag(item.id)
            }
        }
    }
    
    // MARK: - Reordering
    
    @State private var dragInfo = DragInfo<VItem>()
    
    private func reorderableItemList<Content: DynamicViewContent>(@ViewBuilder content: () -> Content) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 5)
                VStack(spacing: 10) {
                    content()
                }
            }
            .padding(.horizontal, 10)
            .environmentObject(dragInfo)
        }
        .background(Color.white)
    }
}

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
