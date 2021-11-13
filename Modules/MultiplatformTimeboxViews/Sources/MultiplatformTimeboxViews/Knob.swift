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

struct Knob_Previews: PreviewProvider {
    static var previews: some View {
        Knob {
            EmptyView()
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
