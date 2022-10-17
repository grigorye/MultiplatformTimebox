import SwiftUI

actor TimeProgressModel {
    @State private var progress: FractionCompleted = 0
}

func timeBasedProgressGenerator(startedAt: Date, timeInterval: TimeInterval, now: @escaping () -> Date) -> FractionCompleted {
    now().timeIntervalSince(startedAt) / timeInterval
}

struct TimeProgressView : View {
    
    let progressNow: () -> FractionCompleted
    
    @State private var progress: FractionCompleted = 0

    init(startedAt: Date, timeInterval: TimeInterval, now: @escaping () -> Date = { Date() }) {
        self.progressNow = {
            timeBasedProgressGenerator(startedAt: startedAt, timeInterval: timeInterval, now: now)
        }
    }
    
    var body: some View {
        ProgressOverlayView(progress: $progress)
            .task {
                while !Task.isCancelled {
                    progress = progressNow()
                    try? await Task.sleep(timeInterval: 0.1)
                }
            }
            .animation(.default, value: progress)
    }
}

extension Task where Success == Never, Failure == Never {
    
    static func sleep(timeInterval: TimeInterval) async throws {
        let duration = UInt64(timeInterval * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
