//
//  MainWindow.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 05/07/2020.
//

import AppKit
import SwiftUI

func newMainWindow() -> NSWindow {
    let window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
        backing: .buffered, defer: false)
    window.setFrameAutosaveName("Main Window")

    return window
}

func newMainContentView<Data, Delegate>(items: Data, delegate: Delegate) -> some View
where
    Data: RandomAccessCollection,
    Delegate: MainContentViewDelegate,
    Delegate.VItem == Data.Element
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
