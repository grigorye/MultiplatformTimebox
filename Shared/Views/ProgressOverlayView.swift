//
//  ProgressView.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 05/07/2020.
//

import SwiftUI

typealias FractionCompleted = Double

struct ProgressOverlayView : View {

    @Binding var progress: FractionCompleted

    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                Color.red
                    .opacity(0.3)
                    .frame(width: metrics.size.width * CGFloat(progress))
                Color.clear
                    .frame(width: metrics.size.width * CGFloat(1 - progress))
            }
        }
    }
}

struct ProgressOverlayView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Text("Foo")
                ProgressOverlayView(progress: .constant(0.3))
            }
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
