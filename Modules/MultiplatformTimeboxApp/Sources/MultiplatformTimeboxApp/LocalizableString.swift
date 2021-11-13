import Foundation

/// Represents a string whose exact phrasing is locale-dependent.
///
/// `LocalizableString` contains a `key` and a series of `arguments`. When the `LocalizableString` is
/// passed to the `String(localized:)` initializer, its `key` is used to find a format string in a
/// `Bundle`'s localized string tables, and the format string is passed with the `arguments` to
/// `String(format:arguments:)` to create the final value.
///
/// `LocalizableString` can be instantiated directly to use it with any key and set of arguments, or
/// it can be instantiated with a string literal, with or without interpolations, to automatically
/// calculate a format string and use it as the key.
///
/// Example:
///
///     let alert = NSAlert()
///     alert.messageText = String(localized: "\(appName) could not add “\(name)” because a person with that name already exists.")
///     alert.addButton(withTitle: String(localized: "Cancel"))
///     alert.addButton(withTitle: String(localized: "Replace"))
public struct LocalizableString {
    public var key: String
    public var arguments: [CVarArg]
    
    public init(key: String, arguments: [CVarArg]) {
        self.key = key
        self.arguments = arguments
    }
    
    public func format(inTable table: String? = nil, from bundle: Bundle = .main) -> String {
        return bundle.localizedString(forKey: key, value: key, table: table)
    }
}

extension String {
    /// Converts a localizable string into a concrete, fully localized `String`.
    public init(localized str: LocalizableString, inTable table: String? = nil, from bundle: Bundle = .main) {
        self.init(format: str.format(inTable: table, from: bundle), arguments: str.arguments)
    }
}

public protocol LocalizableStringInterpolatable {
    var localizableKeyFormat: String { get }
    var localizableValue: CVarArg { get }
}

extension Int: LocalizableStringInterpolatable {
    public var localizableKeyFormat: String { return "%lld" }
    public var localizableValue: CVarArg { return Int64(self) }
}

extension String: LocalizableStringInterpolatable {
    public var localizableKeyFormat: String { return "%@" }
    public var localizableValue: CVarArg { return self as NSString }
}

// Other conformances omitted
extension LocalizableString: ExpressibleByStringInterpolation {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.key = value
        self.arguments = []
    }

    public init(stringInterpolation: StringInterpolation) {
        self.init(key: stringInterpolation.key, arguments: stringInterpolation.arguments)
    }
    
    public struct StringInterpolation: StringInterpolationProtocol {
        var key: String = ""
        var arguments: [CVarArg] = []
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            let assumedSizeOfFormatSpecifier = 2
            
            key.reserveCapacity(literalCapacity + interpolationCount * assumedSizeOfFormatSpecifier)
            arguments.reserveCapacity(interpolationCount)
        }
        
        public mutating func appendLiteral(_ literal: String) {
            // Escape any % characters in the literal.
            key.append(contentsOf: literal.lazy.flatMap { $0 == "%" ? "%%" : String($0) })
        }
        
        public mutating func appendInterpolation(_ value: CVarArg, format: String) {
            key += format
            arguments.append(value)
        }
        
        public mutating func appendInterpolation<T: LocalizableStringInterpolatable>(_ value: T) {
            appendInterpolation(value.localizableValue, format: value.localizableKeyFormat)
        }
    }
}
