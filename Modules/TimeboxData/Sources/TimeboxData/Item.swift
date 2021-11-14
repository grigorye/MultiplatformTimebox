import Foundation

public protocol Item: Identifiable, Hashable {
    var index: Int { get set }
    var title: String { get set }
    var timeRemaining: TimeInterval { get set }
    var startedAt: Date? { get }
    var previouslyLogged: TimeInterval { get }
}

extension Item {
    public var isPlaying: Bool {
        startedAt != nil
    }
}

public struct FakeItem: Item, Hashable, Codable, Identifiable {
    
    public init(id: Int, index: Int, title: String, timeRemaining: TimeInterval, startedAt: Date? = nil, previouslyLogged: TimeInterval = 0) {
        self.id = id
        self.index = index
        self.title = title
        self.timeRemaining = timeRemaining
        self.startedAt = startedAt
        self.previouslyLogged = previouslyLogged
    }
    
    public var id: Int
    public var index: Int
    public var title: String
    public var timeRemaining: TimeInterval
    public var startedAt: Date?
    public var previouslyLogged: TimeInterval = 0
}

public let fakeItemData: [FakeItem] = [
    FakeItem(id: 1, index: 1, title: "Test 1", timeRemaining: 90),
    FakeItem(id: 2, index: 2, title: "Test 2", timeRemaining: 3600),
    FakeItem(id: 3, index: 3, title: "Test 3", timeRemaining: 3600 * 24),
    FakeItem(id: 4, index: 4, title: "Test 4", timeRemaining: 3600 * 24)
]
