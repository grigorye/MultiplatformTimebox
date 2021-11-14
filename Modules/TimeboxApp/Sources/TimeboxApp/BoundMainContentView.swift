//
//  BoundMainContentView.swift
//  Timebox
//
//  Created by Grigory Entin on 06/07/2020.
//

import SwiftUI

public struct BoundMainContentView<Delegate, BodyView> : View
where
    Delegate: MainContentViewDelegate,
    Delegate.VItem == CDItem,
    Delegate.Item == CDItem,
    BodyView: View
{
    
    public init(delegate: Delegate, newMainContentView: @escaping ((items: FetchedResults<CDItem>, delegate: Delegate)) -> BodyView) {
        self.delegate = delegate
        self.newMainContentView = newMainContentView
    }
    
    let delegate: Delegate
    
    @FetchRequest(fetchRequest: CDItem.fetchRequestForManualOrder(ascending: false)/*, animation: .default*/)
    var items: FetchedResults<CDItem>
    
    let newMainContentView: ((items: FetchedResults<CDItem>, delegate: Delegate)) -> BodyView
    
    public var body: some View {
        newMainContentView((items: items, delegate: delegate))
    }
}
