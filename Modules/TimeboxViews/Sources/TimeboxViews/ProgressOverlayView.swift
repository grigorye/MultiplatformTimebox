//
//  ProgressView.swift
//  Timebox
//
//  Created by Grigorii Entin on 05/07/2020.
//

import SwiftUI

public typealias FractionCompleted = Double

public struct ProgressOverlayView : View {

    @Binding public var progress: FractionCompleted

    public init(progress: Binding<FractionCompleted>) {
        _progress = progress
    }
    
    public var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 0) {
                Color.accentColor
                    .opacity(0.4)
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
