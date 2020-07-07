//
//  BusinessLogicController.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 05/07/2020.
//

import Foundation
import CoreData

struct BusinessLogicController {
    
    typealias VItem = CDItem
    
    let persistentContainer: NSPersistentContainer
    let started: (CDItem) -> Void
    let stopped: (CDItem) -> Void
    
    func appDidFinishLaunching() throws {
        if let runningItem = try currentlyRunningItem() {
            started(runningItem)
        }
    }
    
    func sync() throws {
        let fetchRequest = CDItem.fetchRequestForManualOrder()
        let snapshot: [CDItem] = try context.fetch(fetchRequest)
        
        for (i, item) in snapshot.enumerated() {
            item.cd_manualOrder = CDManualOrder(i)
        }
        
        try save()
    }
    
    func start(_ item: CDItem) throws {
        if let currentlyRunningItem = try currentlyRunningItem() {
            try stop(currentlyRunningItem)
        }
        
        item.cd_startedAt = Date()
        try save(item)
        
        started(item)
    }
    
    func stop(_ item: CDItem) throws {
        guard let cd_startedAt = item.cd_startedAt else {
            return assertionFailure()
        }
        
        item.cd_startedAt = nil
        item.cd_previouslyLogged += -cd_startedAt.timeIntervalSinceNow
        try save(item)
        
        stopped(item)
    }
    
    func addNewItem() throws {
        let item = try MultiplatformTimebox.addNewItem(persistentContainer: persistentContainer)
        try save(item)
    }
    
    func currentlyRunningItem() throws -> CDItem? {
        try runningItems(persistentContainer: self.persistentContainer).first
    }
    
    func performOnSnapshot(_ action: (inout [CDItem]) throws -> Void) throws {
        let snapshot: [CDItem] = try {
            let fetchRequest = CDItem.fetchRequestForManualOrder()
            var snapshot: [CDItem] = try context.fetch(fetchRequest)
            dump(snapshot.map { $0.title }, name: "before")
            try action(&snapshot)
            dump(snapshot.map { $0.title }, name: "after")
            return snapshot
        }()
        
        for (i, item) in snapshot.enumerated() {
            item.cd_manualOrder = CDManualOrder(i)
        }
        
        try save()

    }
    func moveItems(from indices: IndexSet, to offset: Int) throws {
        try performOnSnapshot { (snapshot) in
            snapshot.move(fromOffsets: indices, toOffset: offset)
        }
    }
    
    func save(_ item: CDItem) throws {
        try save()
    }
    
    func delete(_ item: CDItem) throws {
        item.cd_deleted = true
        try save()
        context.delete(item)
        try save()
    }
    
    func deleteItems(at indices: IndexSet) throws {
        try performOnSnapshot { (snapshot) in
            for i in indices.sorted(by: >) {
                let item = snapshot[i]
                item.cd_deleted = true
            }
        }
        
        try vacuum()
    }
    
    func vacuum() throws {
        let fetchRequest: NSFetchRequest<CDItem> = CDItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: #keyPath(CDItem.cd_deleted) + " == TRUE")
        
        let items = try context.fetch(fetchRequest)
        for i in items {
            context.delete(i)
        }
        try context.save()
    }

    func save() throws {
        #if os(macOS)
        if !context.commitEditing() {
            NSLog("\(#function) unable to commit editing before saving")
        }
        #endif
        try context.save()
    }
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
