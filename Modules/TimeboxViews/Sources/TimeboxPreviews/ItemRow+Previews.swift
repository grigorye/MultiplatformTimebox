@testable import TimeboxViews
import TimeboxData
import SwiftUI

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
