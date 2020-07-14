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
    
    @Environment(\.itemOrderDebugEnabled)
    var itemOrderDebugEnabled: Bool
    
    let hoveredView: HoveredView
    
    init(item: Binding<VItem>, @ViewBuilder hoveredView: @escaping () -> HoveredView) {
        self._item = item
        self.hoveredView = hoveredView()
    }
    
    var body: some View {
        HStack {
            Knob {
                if hovered || item.isPlaying {
                    hoveredView
                }
            }
            SelectableTextField(text: $item.title)
            Text(stringFromTimeInterval(item.previouslyLogged))
                .frame(width: 64, height: nil, alignment: .trailing)
            if let startedAt = item.startedAt {
                TimeIntervalView(timeIntervalPublisher: newTimeRemainingPublisher(date: startedAt.addingTimeInterval(item.timeRemaining)))
                    .frame(width: 64, alignment: .trailing)
            } else {
                TimeIntervalEditor(timeInterval: $item.timeRemaining)
                    .frame(width: 64, height: nil, alignment: .trailing)
            }
            if itemOrderDebugEnabled {
                Text("\(item.index)")
                    .frame(width: 24, height: nil, alignment: .center)
                    .foregroundColor(Color.gray.opacity(0.5))
            }
        }
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

struct IRow : View {
    @State var name: FakeItem
    var body: some View {
        
        ItemRow(item: $name) {
            PlayPauseView(kind: .constant(.pause), action: {  })
        }
    }
}
struct ISelectionDemo : View {
    @State var selectKeeper = Set<String>()
    
    var body: some View {
        
        HStack {
            List(selection: $selectKeeper){
                ForEach(fakeItemData, id: \.id) { name in
                    IRow(name: name)
                }
            }.frame(width: 500, height: 460)
        }
    }
}

#if DEBUG
struct ix_Previews: PreviewProvider {
    static var previews: some View {
        ISelectionDemo()
    }
}
#endif

extension EnvironmentValues {
    var itemOrderDebugEnabled: Bool {
        get {
            return self[ItemOrderDebugEnabledKey.self]
        }
        set {
            self[ItemOrderDebugEnabledKey.self] = newValue
        }
    }
}

struct ItemOrderDebugEnabledKey : EnvironmentKey {

    static let defaultValue: Bool = false
}
