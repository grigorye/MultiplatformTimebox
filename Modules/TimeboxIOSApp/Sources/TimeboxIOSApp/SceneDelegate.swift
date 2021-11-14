import TimeboxData
import TimeboxApp
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let persistentContainer = newPersistentContainer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let businessLogicController = BusinessLogicController(
            persistentContainer: persistentContainer,
            track: { print("Event: \($0)") }
        )
        
        try! businessLogicController.appDidFinishLaunching()
        
        #if false
        let glueBundleURL = Bundle.main.builtInPlugInsURL!.appendingPathComponent("MenuBarProgress.bundle")
        let glueBundle = Bundle(url: glueBundleURL)!
        glueBundle.load()
        #endif
        
        let contentView = BoundMainContentView(
            delegate: businessLogicController,
            newMainContentView: newMainContentView
        )
            .environment(\.managedObjectContext, persistentContainer.viewContext)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror)
            }
        }
    }
}
