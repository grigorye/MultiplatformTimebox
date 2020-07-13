//
//  ListView.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 05/07/2020.
//

import SwiftUI

protocol MainContentViewDelegate : ManuallyReorderableItemRowDelegate, ItemListDelegate {
    func addNewItem() throws
    func start(_ item: VItem) throws
    func stop(_ item: VItem) throws
    func sync() throws
}

func newListView<Data, Delegate>(items: Data, delegate: Delegate) -> some View
where
    Data: RandomAccessCollection,
    Delegate: MainContentViewDelegate,
    Delegate.VItem == Data.Element,
    Delegate.Item == Data.Element
{
    #if false // os(macOS)
    return ManuallyReorderableItemList(
        items: items,
        play: { try delegate.start($0) },
        pause: { try delegate.stop($0) },
        delegate: delegate
    )
    #else
    return ItemList(
        items: items,
        play: { try! delegate.start($0) },
        pause: { try! delegate.stop($0) },
        delegate: delegate
    )
    #endif
}
