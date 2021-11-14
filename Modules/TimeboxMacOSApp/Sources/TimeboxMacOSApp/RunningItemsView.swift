import SwiftUI

public struct RunningItemProgressView : View {
    
    public init() {}
    
    @FetchRequest(fetchRequest: CDItem.fetchRequestForCurrentlyRunningItems())
    private var currentlyRunningItems: FetchedResults<CDItem>
    
    public var body: some View {
        guard let item = currentlyRunningItems.last else {
            return AnyView(EmptyView())
        }
        guard let startedAt = item.startedAt else {
            fatalError()
        }
        let timeRemaining = item.timeRemaining
        return AnyView(TimeProgressView(startedAt: startedAt, timeInterval: timeRemaining))
    }
}
