//
//  AppDelegate.swift
//  Timebox
//
//  Created by Grigorii Entin on 24/06/2020.
//

import Cocoa
import SwiftUI
import Combine

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet var window: NSWindow!
    
    let persistentContainer = newPersistentContainer()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let itemProgressReporter = MenuBarItemProgressReporter()
        
        let businessLogicController = BusinessLogicController(
            persistentContainer: persistentContainer,
            started: itemProgressReporter.startedItem,
            stopped: itemProgressReporter.stoppedItem
        )
        
        try! businessLogicController.appDidFinishLaunching()
        
        let contentView = BoundMainContentView(businessLogicController: businessLogicController)
            .environment(\.managedObjectContext, persistentContainer.viewContext)
        
        let window = newMainWindow()
        window.delegate = self
        window.contentView = NSHostingView(rootView: contentView)
        window.center()
        window.makeKeyAndOrderFront(nil)
    }
    
    // MARK: - Core Data Saving and Undo support
    
    func windowWillReturnUndoManager(_ window: NSWindow) -> UndoManager? {
        dump(persistentContainer.viewContext.undoManager)
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            
            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }
}

extension BusinessLogicController: MainContentViewDelegate {}
