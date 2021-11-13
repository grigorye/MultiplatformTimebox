//
//  CDItem+Item.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 04/07/2020.
//

import Foundation

typealias CDTimeInterval = Double
public typealias CDManualOrder = Int16

extension CDItem : Item {

    public var id: String {
        objectID.uriRepresentation().absoluteString
    }
    
    public var startedAt: Date? {
        cd_startedAt
    }
    
    public var title: String {
        get {
            cd_title ?? ""
        }
        set {
            cd_title = newValue
        }
    }

    public var index: Int {
        get {
            Int(cd_manualOrder)
        }
        set {
            cd_manualOrder = CDManualOrder(newValue)
        }
    }
    
    public var timeRemaining: TimeInterval {
        get {
            TimeInterval(cd_duration)
        }
        set {
            cd_duration = CDTimeInterval(newValue)
        }
    }
    
    public var previouslyLogged: TimeInterval {
        get {
            TimeInterval(cd_previouslyLogged)
        }
    }
}

