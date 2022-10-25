import SwiftUI
#if os(OSX)
import AppKit.NSImage
#endif

struct Knob<Content: View> : View {

    let content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            placeholderView
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            self.content
        }
    }

#if os(OSX)
    private let placeholderView = Image(nsImage: NSImage())
#else
    private let placeholderView = Image(uiImage: UIImage())
#endif
}
