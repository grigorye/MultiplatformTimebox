//
//  CDItem+ManualOrder.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 06/07/2020.
//

import CoreData

extension CDItem {
    
    @nonobjc public class func fetchRequestForManualOrder() -> NSFetchRequest<CDItem> {
        let fetchRequest: NSFetchRequest<CDItem> = self.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(cd_manualOrder), ascending: true)
        ]
        return fetchRequest
    }
}
