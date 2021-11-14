import SwiftUI
import CoreData

extension NSPersistentContainer : ObservableObject {}

#if false

@main
struct TimeboxApp: App {
    
    @StateObject private var persistentContainer = newPersistentContainer()

    var body: some Scene {
        
        let businessLogicController = BusinessLogicController(
            persistentContainer: persistentContainer,
            starting: { print("Started \($0)") },
            stopping: { print("Stopped \($0)") }
        )

        return WindowGroup {
            NavigationView {
                BoundMainContentView(businessLogicController: businessLogicController)
                    .environment(\.managedObjectContext, persistentContainer.viewContext)
            }
        }
    }
}

struct TimeboxApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
#endif
