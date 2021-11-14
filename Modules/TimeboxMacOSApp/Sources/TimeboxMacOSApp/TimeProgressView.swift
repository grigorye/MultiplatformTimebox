//
//  TimeProgressView.swift
//  macOS
//
//  Created by Grigory Entin on 12/07/2020.
//

import SwiftUI
import Combine

struct TimeProgressView : View {
    
    private var progressPublisher: AnyPublisher<FractionCompleted, Timer.TimerPublisher.Failure>
    @State private var progress: FractionCompleted = 0
    
    init(startedAt: Date, timeInterval: TimeInterval) {
        progressPublisher = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .map { (date) -> FractionCompleted in
                date.timeIntervalSince(startedAt) / timeInterval
            }
            .eraseToAnyPublisher()
    }
    
    var body: some View {
        ProgressOverlayView(progress: $progress)
            .onReceive(progressPublisher) {
                progress = $0
            }
            .animation(.default)
    }
}
