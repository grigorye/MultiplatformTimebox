//
//  TimeIntervalEditor.swift
//  MultiplatformTimebox
//
//  Created by Grigory Entin on 04/07/2020.
//

import SwiftUI

struct TimeIntervalEditor : View {
    
    @Binding var timeInterval: TimeInterval
    
    @State private var timeIntervalString: String = ""
    
    var body: some View {
        TextField(
            "",
            text: $timeIntervalString,
            onEditingChanged: { _ in
                timeInterval = timeIntervalFromString(timeIntervalString)
            }
        )
        .onAppear {
            self.timeIntervalString = stringFromTimeInterval(timeInterval)
        }
        .multilineTextAlignment(.trailing)
    }
}

struct TimeIntervalEditor_Previews : PreviewProvider {
    
    private struct TimeIntervalEditorSample : View {
        @State private var timeInterval: TimeInterval = 70
        
        var body: some View {
            TimeIntervalEditor(timeInterval: $timeInterval)
        }
    }
    
    static var previews: some View {
        TimeIntervalEditorSample()
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
