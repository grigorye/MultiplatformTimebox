//
//  CDItem+ManualOrder.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 06/07/2020.
//

import CoreData

extension CDItem {
    
    @nonobjc public class func fetchRequestForManualOrder(ascending: Bool = true) -> NSFetchRequest<CDItem> {
        let fetchRequest: NSFetchRequest<CDItem> = self.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(cd_manualOrder), ascending: ascending)
        ]
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequestForCurrentlyRunningItems(ascending: Bool = true) -> NSFetchRequest<CDItem> {
        let fetchRequest: NSFetchRequest<CDItem> = CDItem.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(cd_manualOrder), ascending: ascending)
        ]
        fetchRequest.predicate = NSPredicate(format: #keyPath(CDItem.cd_startedAt) + " != nil")
        return fetchRequest
    }
}
