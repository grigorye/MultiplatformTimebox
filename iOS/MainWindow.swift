//
//  MainWindow.swift
//  MultiplatformTimebox/iOS
//
//  Created by Grigory Entin on 05/07/2020.
//

import SwiftUI

func newMainContentView<Data, Delegate>(items: Data, delegate: Delegate) -> some View
where
    Data: RandomAccessCollection,
    Delegate: MainContentViewDelegate,
    Delegate.VItem == Data.Element,
    Delegate.Item == Data.Element
{
    NavigationView {
        newListView(items: items, delegate: delegate)
            .navigationBarItems(
                leading: Button("Sync") {
                    try! delegate.sync()
                },
                trailing: HStack {
                    Button("Add") {
                        try! delegate.addNewItem()
                    }
                    EditButton()
                }
            )
            .navigationBarTitle("Welcome")
    }
}
