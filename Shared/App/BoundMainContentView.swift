//
//  BoundMainContentView.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 06/07/2020.
//

import SwiftUI

struct BoundMainContentView : View {
    
    let businessLogicController: BusinessLogicController
    
    @FetchRequest(fetchRequest: CDItem.fetchRequestForManualOrder(ascending: false)/*, animation: .default*/)
    var items: FetchedResults<CDItem>
    
    var body: some View {
        newMainContentView(items: items, delegate: businessLogicController)
    }
}
