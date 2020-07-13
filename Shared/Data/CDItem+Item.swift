//
//  CDItem+Item.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 04/07/2020.
//

import Foundation

typealias CDTimeInterval = Double
typealias CDManualOrder = Int16

extension CDItem : Item {

    public var id: String {
        objectID.uriRepresentation().absoluteString
    }
    
    var startedAt: Date? {
        cd_startedAt
    }
    
    var title: String {
        get {
            cd_title ?? ""
        }
        set {
            cd_title = newValue
        }
    }

    var index: Int {
        get {
            Int(cd_manualOrder)
        }
        set {
            cd_manualOrder = CDManualOrder(newValue)
        }
    }
    
    var timeRemaining: TimeInterval {
        get {
            TimeInterval(cd_duration)
        }
        set {
            cd_duration = CDTimeInterval(newValue)
        }
    }
    
    var previouslyLogged: TimeInterval {
        get {
            TimeInterval(cd_previouslyLogged)
        }
    }
}

