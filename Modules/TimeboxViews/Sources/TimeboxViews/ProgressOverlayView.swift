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
