import Cocoa
import SwiftUI
import Combine

open class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    @IBOutlet var window: NSWindow!
    
    let persistentContainer = newPersistentContainer()
    
    var cancellables: [AnyCancellable] = []
    
    public func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        try! persistentContainer.viewContext.setQueryGenerationFrom(.current)

        let eventPublisher = PassthroughSubject<BusinessLogicEvent, Never>()
        
        let businessLogicController = BusinessLogicController(
            persistentContainer: persistentContainer,
            track: eventPublisher.send
        )
        
        let undoManager = persistentContainer.viewContext.undoManager!
        let undoController = UndoController(undoManager: undoManager)
        eventPublisher
            .sink(receiveValue: undoController.receive)
            .store(in: &cancellables)

        try! businessLogicController.appDidFinishLaunching()
        
        #if true
        let menuBarContentView =
            RunningItemProgressView()
            .environment(\.managedObjectContext, persistentContainer.viewContext)

        addMenuBarOverlayWindow(rootView: menuBarContentView)
        #endif
        
        let mainContentView = BoundMainContentView(
            delegate: businessLogicController,
            newMainContentView: newMainContentView
        )
        .environment(\.managedObjectContext, persistentContainer.viewContext)

        addMainWindow(rootView: mainContentView)
    }
    
    private func addMainWindow<Content>(rootView: Content) where Content : View {
        let window = newMainWindow()
        window.delegate = self
        let rootViewWithHostingWindow = rootView.environment(\.hostingWindow, { [weak window] in window })
        window.contentView = NSHostingView(rootView: rootViewWithHostingWindow)
        window.center()
        window.makeKeyAndOrderFront(nil)
    }
    
    private func addMenuBarOverlayWindow<Content>(rootView: Content) where Content : View {
        let window = newMenuBarOverlayWindow()
        window.contentView = NSHostingView(rootView: rootView)
        window.orderFrontRegardless()
    }
    
    // MARK: - Core Data Saving and Undo support
    
    public func windowWillReturnUndoManager(_ window: NSWindow) -> UndoManager? {
        persistentContainer.viewContext.undoManager
    }
    
    public func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
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
