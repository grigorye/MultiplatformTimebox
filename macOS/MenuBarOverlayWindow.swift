//
//  MenuBarOverlayWindow.swift
//  macOS
//
//  Created by Grigory Entin on 12/07/2020.
//

import AppKit

func newMenuBarOverlayWindow() -> NSWindow {
    
    let windowRect = NSScreen.main!.frame
    
    let (menuBarRect, _) = windowRect.divided(atDistance: NSApplication.shared.mainMenu!.menuBarHeight, from: CGRectEdge.maxYEdge)
    
    let overlayWindow = NSWindow(contentRect: menuBarRect, styleMask: .borderless, backing: .buffered, defer: false, screen: NSScreen.screens[0])
    
    let overlayCGWindowLevel = CGWindowLevelForKey(.mainMenuWindow)
    
    overlayWindow.ignoresMouseEvents = true
    overlayWindow.level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(overlayCGWindowLevel))
    overlayWindow.backgroundColor = .clear
    
    return overlayWindow
}
