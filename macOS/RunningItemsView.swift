//
//  RunningItemsView.swift
//  macOS
//
//  Created by Grigory Entin on 12/07/2020.
//

import SwiftUI

struct RunningItemProgressView : View {
    
    @FetchRequest(fetchRequest: CDItem.fetchRequestForCurrentlyRunningItems())
    private var currentlyRunningItems: FetchedResults<CDItem>
    
    var body: some View {
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
