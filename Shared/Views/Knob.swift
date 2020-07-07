//
//  Knob.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 03/07/2020.
//

import SwiftUI
#if os(OSX)
import AppKit.NSImage
#endif

struct Knob<Content: View> : View {

    let content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    #if os(OSX)
    var body: some View {
        ZStack {
            Image(nsImage: NSImage(named: "x")!)
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            self.content
        }
    }
    #else
    var body: some View {
        EmptyView()
    }
    #endif

}

struct Knob_Previews: PreviewProvider {
    static var previews: some View {
        Knob {
            EmptyView()
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
