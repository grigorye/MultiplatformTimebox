//
//  Item.swift
//  Timebox
//
//  Created by Grigorii Entin on 25/06/2020.
//

import Foundation

protocol Item: Identifiable, Hashable {
    var index: Int { get set }
    var title: String { get set }
    var timeRemaining: TimeInterval { get set }
    var startedAt: Date? { get }
    var previouslyLogged: TimeInterval { get }
}

extension Item {
    var isPlaying: Bool {
        startedAt != nil
    }
}

struct FakeItem: Item, Hashable, Codable, Identifiable {
    var id: Int
    var index: Int
    var title: String
    var timeRemaining: TimeInterval
    var startedAt: Date?
    var previouslyLogged: TimeInterval = 0
}

let fakeItemData: [FakeItem] = [
    FakeItem(id: 1, index: 1, title: "Test 1", timeRemaining: 90),
    FakeItem(id: 2, index: 2, title: "Test 2", timeRemaining: 3600),
    FakeItem(id: 3, index: 3, title: "Test 3", timeRemaining: 3600 * 24),
    FakeItem(id: 4, index: 4, title: "Test 4", timeRemaining: 3600 * 24)
]
