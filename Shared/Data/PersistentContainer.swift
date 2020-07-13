//
//  PersistentContainer.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 29/06/2020.
//

import CoreData

func newPersistentContainer() -> NSPersistentCloudKitContainer {
    
    let container = NSPersistentCloudKitContainer(name: "Timebox")
    
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
