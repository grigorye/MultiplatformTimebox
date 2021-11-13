//
//  UndoController.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 12/07/2020.
//

import Foundation.NSUndoManager

public struct UndoController {
    
    public init(undoManager: UndoManager) {
        self.undoManager = undoManager
    }

    let undoManager: UndoManager

    public func receive(_ event: BusinessLogicEvent) {
        if let undoActionName = undoActionName(for: event) {
            undoManager.setActionName(undoActionName)
        }
    }
    
    func undoActionName(for event: BusinessLogicEvent) -> String? {
        switch event {
        case .addingItem:
            return nil
        case .added(let item):
            return String(localized: "Add '\(item.title)'")

        case .deleting(let item):
            return String(localized: "Delete '\(item.title)'")
        case .deletedItem:
            return nil

        case .deletingItems:
            return nil
        case .deletedItems(let count):
            return String(localized: "Delete \(count) Items")

        case .starting:
            return nil
        case .started(let item):
            let now = momentFormatter.string(from: Date())
            return String(localized: "Start '\(item.title)' at \(now)")
        
        case .stopping(let item):
            let now = momentFormatter.string(from: Date())
            return String(localized: "Stop '\(item.title)' at \(now)")
        case .stopped:
            return nil
        
        case .movingItems:
            return nil
        case .movedItems(from: let indices, to: _):
            return String(localized: "Move \(indices.count) Items")
        
        case .syncingItems:
            return nil
        case .syncedItems:
            return String(localized: "Sync Items")
        }
    }
}

private let momentFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    return dateFormatter
}()
