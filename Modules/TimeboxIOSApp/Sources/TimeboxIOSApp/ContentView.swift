import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Text("Hello, world!").padding()
            Text("Hello, world!").padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Name: Identifiable, Hashable {
    var id: String
    var name = ""
}

var demoData: [Name] = [.init(id: "Phil Swanson", name: "Phil Swanson"), .init(id: "Karen Gibbons", name: "Karen Gibbons"), .init(id: "3", name: "Grant Kilman"), .init(id: "4", name: "Wanda Green")]

struct Row : View {
    @State var name: Name
    var body: some View {
        
        HStack {
            Text(name.name)
            Text("Foo")
            Button("Foo", action: {})
        }
    }
}
struct SelectionDemo : View {
    @State var selectKeeper = Set<String>()
    
    var body: some View {
        
        HStack {
            List(selection: $selectKeeper){
                ForEach(demoData, id: \.id) { name in
                    Row(name: name)
                }
            }.frame(width: 500, height: 460)
        }
    }
}

#if DEBUG
struct x_Previews: PreviewProvider {
    static var previews: some View {
        SelectionDemo()
    }
}
#endif
