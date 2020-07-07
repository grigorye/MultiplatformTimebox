//
//  SceneDelegate.swift
//  Catalyst
//
//  Created by Grigory Entin on 04/07/2020.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let persistentContainer = newPersistentContainer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let businessLogicController = BusinessLogicController(
            persistentContainer: persistentContainer,
            started: { print("Started \($0)") },
            stopped: { print("Stopped \($0)") }
        )
        
        try! businessLogicController.appDidFinishLaunching()
        
        let contentView =
            BoundMainContentView(businessLogicController: businessLogicController)
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

extension BusinessLogicController : MainContentViewDelegate {}
