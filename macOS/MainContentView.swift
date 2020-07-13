//
//  MainContentView.swift
//  macOS
//
//  Created by Grigory Entin on 12/07/2020.
//

import SwiftUI

func newMainContentView<Data, Delegate>(items: Data, delegate: Delegate) -> some View
where
    Data: RandomAccessCollection,
    Delegate: MainContentViewDelegate,
    Delegate.VItem == Data.Element,
    Delegate.Item == Data.Element
{
    VStack(alignment: .trailing) {
        VStack(alignment: .trailing) {
            HStack {
                Button(action: { try! delegate.sync() }) {
                    Text("Sync")
                }
                Button(action: { try! delegate.addNewItem() }) {
                    Text("Add")
                }
            }
            .padding()
        }
        newListView(items: items, delegate: delegate)
    }
}
