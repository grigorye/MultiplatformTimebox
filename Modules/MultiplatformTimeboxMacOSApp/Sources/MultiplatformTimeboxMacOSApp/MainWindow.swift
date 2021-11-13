//
//  MainWindow.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 05/07/2020.
//

import AppKit

func newMainWindow() -> NSWindow {
    let window = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
        backing: .buffered, defer: false)
    window.setFrameAutosaveName("Main Window")

    return window
}
