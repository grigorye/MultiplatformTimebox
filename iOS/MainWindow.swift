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
    Delegate.VItem == Data.Element
{
    NavigationView {
        newListView(items: items, delegate: delegate)
            .navigationBarTitle("Welcome")
            .navigationBarItems(
                leading: Button("Sync") {
                    try! delegate.sync()
                },
                trailing: Button("Add") {
                    try! delegate.addNewItem()
                }
            )
    }
}
