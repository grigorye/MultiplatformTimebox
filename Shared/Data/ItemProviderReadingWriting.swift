//
//  ItemProviderReadingWriting.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 04/07/2020.
//

import Foundation
import CoreServices

final class ItemProviderReadingWriting: NSObject, Codable, NSItemProviderReading, NSItemProviderWriting {
    
    var collectionName : String?
    
    init(collectionName: String) {
        self.collectionName = collectionName
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        
        let progress = Progress(totalUnitCount: 100)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        
        return progress
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let decoder = JSONDecoder()
        do {
            let myJSON = try decoder.decode(Self.self, from: data)
            return myJSON
        } catch {
            fatalError("Err")
        }
    }
}



