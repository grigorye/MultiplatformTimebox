//
//  MenuBarItemProgressReporter.swift
//  MultiplatformTimebox/macOS
//
//  Created by Grigorii Entin on 05/07/2020.
//

import AppKit

class MenuBarItemProgressReporter {

    private var overlayProgressWindow: NSWindow?

    func startedItem(_ item: CDItem) {
        assert(overlayProgressWindow == nil)

        let overlayProgressWindow = newOverlayProgressWindow(startedAt: item.startedAt!, timeInterval: item.timeRemaining)
        overlayProgressWindow.orderFrontRegardless()
        self.overlayProgressWindow = overlayProgressWindow
    }

    func stoppedItem(_ item: CDItem) {
        guard let overlayProgressWindow = overlayProgressWindow else {
            return assertionFailure()
        }

        overlayProgressWindow.orderOut(nil)

        self.overlayProgressWindow = nil
    }
}
