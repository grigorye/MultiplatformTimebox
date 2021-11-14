import Foundation
import CoreData

public struct BusinessLogicController {
    
    public init(persistentContainer: NSPersistentContainer, track: @escaping (BusinessLogicEvent) -> Void) {
        self.persistentContainer = persistentContainer
        self.track = track
    }
    
    public typealias VItem = CDItem
    
    let persistentContainer: NSPersistentContainer
    let track: (BusinessLogicEvent) -> Void
    
    public func appDidFinishLaunching() throws {
        if let runningItem = try currentlyRunningItem() {
            track(.started(runningItem))
        }
    }
    
    public func sync() throws {
        track(.syncingItems)
        defer {
            track(.syncedItems)
        }
        
        let fetchRequest = CDItem.fetchRequestForManualOrder()
        let snapshot: [CDItem] = try context.fetch(fetchRequest)
        
        for (i, item) in snapshot.enumerated() {
            item.cd_manualOrder = CDManualOrder(i)
        }
        
        try save()
    }
    
    public func start(_ item: CDItem) throws {
        track(.starting(item))
        defer {
            track(.started(item))
        }
        
        if let currentlyRunningItem = try currentlyRunningItem() {
            try stop(currentlyRunningItem)
        }
        
        item.cd_startedAt = Date()
        try save(item)
        
        assert(try! currentlyRunningItem() == item)
    }
    
    public func stop(_ item: CDItem) throws {
        track(.stopping(item))
        defer {
            track(.stopped(item))
        }

        guard let cd_startedAt = item.cd_startedAt else {
            return assertionFailure()
        }
        
        item.cd_startedAt = nil
        item.cd_previouslyLogged += -cd_startedAt.timeIntervalSinceNow
        try save(item)
        
        assert(try! currentlyRunningItem() == nil)
    }
    
    public func addNewItem() throws {
        let item = CDItem(context: context)

        track(.addingItem)
        defer {
            track(.added(item))
        }
        
        let existingCount = try CDManualOrder(context.count(for: CDItem.fetchRequest()))
        
        item.title = "Item \(existingCount)"
        item.timeRemaining = TimeInterval(30 * 60)
        item.cd_manualOrder = existingCount
        try save(item)
    }
    
    public func moveItems(from indices: IndexSet, to offset: Int) throws {
        track(.movingItems(from: indices, to: offset))
        defer {
            track(.movedItems(from: indices, to: offset))
        }
        try performOnSnapshot { (snapshot) in
            snapshot.reverse()
            snapshot.move(fromOffsets: indices, toOffset: offset)
            snapshot.reverse()
        }
    }
    
    public func deleteItems(at indices: IndexSet) throws {
        try performOnSnapshot { (snapshot) in
            let items = indices.map { snapshot[$0] }
            try delete(items)
        }
    }
    
    public func deleteItems(withIDs ids: Set<CDItem.ID>) throws {
        track(.deletingItems(ids.count))
        defer {
            track(.deletedItems(ids.count))
        }
        guard let persistentStoreCoordinator = context.persistentStoreCoordinator else {
            fatalError()
        }
        let items: [CDItem] = ids.map { id in
            guard let uri = URL(string: id) else {
                fatalError()
            }
            guard let objectID = persistentStoreCoordinator.managedObjectID(forURIRepresentation: uri) else {
                fatalError()
            }
            let item = context.object(with: objectID) as! CDItem
            return item
        }
        try delete(items)
    }

    public func delete(_ item: CDItem) throws {
        track(.deleting(item))
        defer {
            track(.deletedItem)
        }
        try delete([item])
    }

    public func save() throws {
        #if os(macOS)
        if !context.commitEditing() {
            NSLog("\(#function) unable to commit editing before saving")
        }
        #endif
        try context.save()
    }
    
    // MARK: -
    
    private func currentlyRunningItem() throws -> CDItem? {
        let items = try context.fetch(CDItem.fetchRequestForCurrentlyRunningItems())
        assert(items.count <= 1)
        return items.first
    }
    
    private func performOnSnapshot(_ action: (inout [CDItem]) throws -> Void) throws {
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
    
    private func save(_ item: CDItem) throws {
        try save()
    }
    
    private func delete(_ items: [CDItem]) throws {
        for item in items {
            item.cd_deleted = true
        }
        try save()
        
        try vacuum()
    }

    private func vacuum() throws {
        let fetchRequest: NSFetchRequest<CDItem> = CDItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: #keyPath(CDItem.cd_deleted) + " == TRUE")
        
        let items = try context.fetch(fetchRequest)
        for i in items {
            context.delete(i)
        }
        try context.save()
    }

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
