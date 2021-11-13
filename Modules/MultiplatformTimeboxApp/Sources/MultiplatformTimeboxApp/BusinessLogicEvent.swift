//
//  BusinessLogicEvent.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 12/07/2020.
//

import Foundation

public enum BusinessLogicEvent {
    case addingItem
    case added(_ item: CDItem)
    case starting(_ item: CDItem)
    case started(_ item: CDItem)
    case stopping(_ item: CDItem)
    case stopped(_ item: CDItem)
    case movingItems(from: IndexSet, to: Int)
    case movedItems(from: IndexSet, to: Int)
    case deleting(_ item: CDItem)
    case deletedItem
    case deletingItems(_ count: Int)
    case deletedItems(_ count: Int)
    case syncingItems
    case syncedItems
}
