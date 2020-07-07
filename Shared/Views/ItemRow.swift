//
//  ItemView.swift
//  Timebox
//
//  Created by Grigorii Entin on 24/06/2020.
//

import SwiftUI
import Foundation

struct ItemRow<VItem: Item, HoveredView: View> : View {
    
    @Binding var item: VItem
    
    @State private var hovered: Bool = false
    
    private let hoveredView: HoveredView
    
    init(item: Binding<VItem>, @ViewBuilder hoveredView: @escaping () -> HoveredView) {
        self._item = item
        self.hoveredView = hoveredView()
    }
    
    var body: some View {
        HStack {
            Knob {
                if hovered {
                    hoveredView
                }
            }
            Text("\(item.index)")
                .frame(width: 24, height: nil, alignment: .trailing)
            TextField("", text: $item.title, onEditingChanged: {_ in }, onCommit: {})
            Text(stringFromTimeInterval(item.previouslyLogged))
                .frame(width: 64, height: nil, alignment: .trailing)
            if let startedAt = item.startedAt {
                TimeIntervalView(timeIntervalPublisher: newTimeRemainingPublisher(date: startedAt.addingTimeInterval(item.timeRemaining)))
                    .frame(width: 64, alignment: .trailing)
            } else {
                TimeIntervalEditor(timeInterval: $item.timeRemaining)
                    .frame(width: 64, height: nil, alignment: .trailing)
            }
        }
        .background(item.isPlaying ? Color.red : Color.white)
        .textFieldStyle(PlainTextFieldStyle())
        .onHover { (hover) in
            hovered = hover
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemRow(item: .constant(FakeItem(id: 1, index: 1, title: "Test 1", timeRemaining: 90)), hoveredView: { EmptyView() })
                .padding()
            ItemRow(item: .constant(FakeItem(id: 2, index: 2, title: "Test 2", timeRemaining: 3600)), hoveredView: { EmptyView() })
                .padding()
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
