import TimeboxData
import SwiftUI
import Foundation

class DragInfo<VItem: Item> : ObservableObject {
    @Published var item: VItem?
}

public protocol ManuallyReorderableItemRowDelegate {
    associatedtype VItem: Item
    
    func save() throws
    func moveItems(from indices: IndexSet, to offset: Int) throws
    func delete(_ item: VItem) throws
}

struct ManuallyReorderableItemRow<Content, VItem, Delegate> : View
where
    Content: View,
    Delegate: ManuallyReorderableItemRowDelegate,
    Delegate.VItem == VItem
{
    
    private let content: () -> Content
    
    @EnvironmentObject var dragInfo: DragInfo<VItem>
    
    @State private var translation: CGSize = .zero
    @State private var hovered: Bool = false
    @Binding var item: VItem
    
    let delegate: Delegate?
    
    init(item: Binding<VItem>, delegate: Delegate?, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self._item = item
        self.delegate = delegate
    }
    
    var body: some View {
        HStack {
            content()
            Knob {
                Text("...")
            }
            .contextMenu {
                Button(action: {
                    try! delegate?.delete(item)
                }) {
                    Text("Delete")
                }
                
                Button(action: {
                    // enable geolocation
                }) {
                    Text("Detect Location")
                }
            }
        }
        .offset(x: 0, y: translation.height)
        .zIndex(dragInfo.item?.index == item.index ? 1 : 0)
        .onHover(perform: { (hover) in
            guard var draggedItem = dragInfo.item else {
                return
            }
            
            guard draggedItem.index != item.index else {
                print("Hovering drag")
                return
            }
            
            let index = item.index
            
            guard hover else {
                if hovered == false {
                    print("Leaving non hovered \(index)")
                    return
                }
                print("Leaving \(index)")
                hovered = false
                return
            }
            
            guard hovered == false else {
                print("Hovering already hovered \(index)")
                return
            }
            
            hovered = true
            
            print("Hovering \(index)")
            
            let indexDelta = (draggedItem.index > index) ? +1 : -1
            
            /* withAnimation */ do {
                draggedItem.index -= indexDelta
                item.index += indexDelta
                
                try! delegate?.save()
            }
        })
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if dragInfo.item == nil {
                        print("Drag started")
                    }
                    dragInfo.item = item
                    translation = gesture.translation
                }
                .onEnded { gesture in
                    print("Drag ended")
                    dragInfo.item = nil
                    translation = .zero
                }
        )
    }
}
