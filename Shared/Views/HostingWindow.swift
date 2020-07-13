//
//  HostingWindow.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 13/07/2020.
//

import SwiftUI

struct HostingWindowKey: EnvironmentKey {

#if canImport(UIKit)
    typealias WrappedValue = UIWindow
#elseif canImport(AppKit)
    typealias WrappedValue = NSWindow
#else
    #error("Unsupported platform")
#endif

    typealias Value = () -> WrappedValue? // needed for weak link
    static let defaultValue: Self.Value = { nil }
}

extension EnvironmentValues {
    var hostingWindow: HostingWindowKey.Value {
        get {
            return self[HostingWindowKey.self]
        }
        set {
            self[HostingWindowKey.self] = newValue
        }
    }
}
