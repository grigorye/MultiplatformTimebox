//
//  AppDelegate.swift
//  MenuBarApp
//
//  Created by Grigory Entin on 12/07/2020.
//

import TimeboxMacOSApp
import TimeboxViews
import Cocoa
import SwiftUI
import Combine

open class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet var window: NSWindow!
    
    let persistentContainer = newPersistentContainer()
    
    var cancellables: [AnyCancellable] = []
    
    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        try! persistentContainer.viewContext.setQueryGenerationFrom(.current)
        
        let menuBarContentView =
            RunningItemProgressView()
            .environment(\.managedObjectContext, persistentContainer.viewContext)
        
        addMenuBarOverlayWindow(rootView: menuBarContentView)
    }
    
    private func addMenuBarOverlayWindow<Content>(rootView: Content) where Content : View {
        let window = newMenuBarOverlayWindow()
        window.contentView = NSHostingView(rootView: rootView)
        window.orderFrontRegardless()
    }
}
