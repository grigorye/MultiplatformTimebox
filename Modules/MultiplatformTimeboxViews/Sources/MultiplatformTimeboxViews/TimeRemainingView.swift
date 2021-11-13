//
//  TimeRemainingView.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 05/07/2020.
//

import MultiplatformTimeboxData
import SwiftUI
import Combine

func newTimeRemainingPublisher(date: Date) -> AnyPublisher<TimeInterval, Timer.TimerPublisher.Failure> {
    
    Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .map { (_) -> TimeInterval in
            date.timeIntervalSinceNow
        }
        .eraseToAnyPublisher()
}

struct TimeIntervalView : View/*, TimeIntervalFormatting*/ {
    
    @State var timeInterval: TimeInterval = 0
    
    var timeIntervalPublisher: AnyPublisher<TimeInterval, Timer.TimerPublisher.Failure>
    
    var body: some View {
        Text(stringFromTimeInterval(timeInterval))
            .onReceive(timeIntervalPublisher) {
                timeInterval = $0
            }
    }
}
