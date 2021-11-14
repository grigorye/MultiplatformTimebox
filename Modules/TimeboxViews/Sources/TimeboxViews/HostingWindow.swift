//
//  HostingWindow.swift
//  Timebox
//
//  Created by Grigorii Entin on 13/07/2020.
//

import SwiftUI

public struct HostingWindowKey: EnvironmentKey {

#if canImport(UIKit)
public typealias WrappedValue = UIWindow
#elseif canImport(AppKit)
public typealias WrappedValue = NSWindow
#else
    #error("Unsupported platform")
#endif

    public typealias Value = () -> WrappedValue? // needed for weak link
    public static let defaultValue: Self.Value = { nil }
}

extension EnvironmentValues {
    public var hostingWindow: HostingWindowKey.Value {
        get {
            return self[HostingWindowKey.self]
        }
        set {
            self[HostingWindowKey.self] = newValue
        }
    }
}
