//
//  OverlayProgressWindow.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 05/07/2020.
//

import Combine
import AppKit
import SwiftUI

func newOverlayProgressWindow(startedAt: Date, timeInterval: TimeInterval) -> NSWindow {

    let windowRect = NSScreen.main!.frame

    let (menuBarRect, _) = windowRect.divided(atDistance: NSApplication.shared.mainMenu!.menuBarHeight, from: CGRectEdge.maxYEdge)

    let overlayWindow = NSWindow(contentRect: menuBarRect, styleMask: .borderless, backing: .buffered, defer: false, screen: NSScreen.screens[0])

    let overlayCGWindowLevel = CGWindowLevelForKey(.mainMenuWindow)
    
    overlayWindow.ignoresMouseEvents = true
    overlayWindow.level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(overlayCGWindowLevel))
    overlayWindow.backgroundColor = .clear

    let progressPublisher = Timer.publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
        .map { (date) -> FractionCompleted in
            date.timeIntervalSince(startedAt) / timeInterval
        }
        .eraseToAnyPublisher()

    struct CombinedOverlayView : View {

        @State var progress: FractionCompleted = 0
        var progressPublisher: AnyPublisher<FractionCompleted, Timer.TimerPublisher.Failure>

        var body: some View {
            ProgressOverlayView(progress: $progress)
                .onReceive(progressPublisher) {
                    progress = $0
                }
                .animation(.default)
        }
    }

    let overlayView = CombinedOverlayView(progressPublisher: progressPublisher)

    overlayWindow.contentView = NSHostingView(rootView: VStack { overlayView })

    return overlayWindow
}
