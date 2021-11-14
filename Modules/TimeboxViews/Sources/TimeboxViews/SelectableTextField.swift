import SwiftUI
#if os(macOS)
import Introspect
#endif

struct SelectableTextField : View {

    @Binding var text: String
    var onCommit: () -> Void = {}

    #if !os(macOS)
    
    var body: some View {
        TextField("", text: $text, onCommit: onCommit)
    }
    
    #else
    
    @Environment(\.hostingWindow)
    private var hostingWindow: () -> NSWindow?
    
    @State private var textField: NSTextField?
    @State private var focused = false
    
    var body: some View {
        ZStack {
            AppKitIntrospectionView(
                selector: { introspectionView in
                    guard let viewHost = Introspect.findViewHost(from: introspectionView) else {
                        return nil
                    }
                    return Introspect.nextSiblingTextField(from: viewHost)
                },
                customize: { (textFieldView) in
                    textField = (textFieldView as! NSTextField)
                }
            )
            TextField("", text: $text, onCommit: onCommit)
                .foregroundColor(focused ? .black : nil)
                .onReceive(hostingWindow()!.publisher(for: \.firstResponder)) { (responder) in
                    focused = (textField == responder) || (textField?.currentEditor() == responder)
                }
        }
    }
    
    #endif
}


#if os(macOS)

extension Introspect {
    
    public static func nextSiblingTextField(
        from entry: NSView
    ) -> NSTextField? {
        
        guard let superview = entry.superview else {
            return nil
        }
        let subviews = superview.subviews
        guard let i = subviews.firstIndex(of: entry) else {
            return nil
        }
        
        let subview = subviews[i + 1]
        
        if let typed = subview as? NSTextField {
            return typed
        }
        for subview2 in subview.subviews {
            if let typed = subview2 as? NSTextField {
                return typed
            }
            for subview3 in subview2.subviews {
                if let typed = subview3 as? NSTextField {
                    return typed
                }
            }
        }
        
        return nil
    }
}

#endif
