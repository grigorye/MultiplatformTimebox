import TimeboxData
import TimeFormatting
import SwiftUI
import Foundation

struct ItemRow<VItem: Item, HoveredView: View> : View, TimeIntervalFormatting {
    
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
                .fixedSize()
            Spacer()
                .frame(maxWidth: .infinity)
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
