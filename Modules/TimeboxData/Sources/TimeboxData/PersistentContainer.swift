//
//  PersistentContainer.swift
//  Timebox
//
//  Created by Grigorii Entin on 29/06/2020.
//

import CoreData

public func newPersistentContainer() -> NSPersistentCloudKitContainer {
    
    let modelURL = Bundle.module.url(forResource: "Timebox", withExtension: "momd")!
    let model = NSManagedObjectModel(contentsOf: modelURL)!
    let container = NSPersistentCloudKitContainer(name: "Timebox", managedObjectModel: model)
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        dump(storeDescription)
        if let error = error {
            fatalError("Unresolved error \(error)")
        }
    })
    
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    
    container.viewContext.undoManager = UndoManager()
    
    return container
}
