//
//  MultiplatformTimeboxApp.swift
//  Shared
//
//  Created by Grigorii Entin on 25/06/2020.
//

import SwiftUI
import CoreData

extension NSPersistentContainer : ObservableObject {}

#if false

@main
struct MultiplatformTimeboxApp: App {
    
    @StateObject private var persistentContainer = newPersistentContainer()

    var body: some Scene {
        
        let businessLogicController = BusinessLogicController(
            persistentContainer: persistentContainer,
            started: { print("Started \($0)") },
            stopped: { print("Stopped \($0)") }
        )

        return WindowGroup {
            NavigationView {
                BoundMainContentView(businessLogicController: businessLogicController)
                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }
        }
    }
}

struct MultiplatformTimeboxApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
#endif
