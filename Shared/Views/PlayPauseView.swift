//
//  PlayPauseView.swift
//  MultiplatformTimebox
//
//  Created by Grigorii Entin on 05/07/2020.
//

import SwiftUI

enum PlayPauseKind {
    case play
    case pause
}

struct PlayPauseView : View {
    
    @Binding var kind: PlayPauseKind
    
    let action: () -> Void
    
    func imageName(for kind: PlayPauseKind) -> String {
        switch kind {
        case .play:
            return "play.fill"
        case .pause:
            return "pause.fill"
        }
    }
    
    var body: some View {
        Button(action: action) {
            Image(imageName(for: kind))
                .resizable()
                .frame(width: 16, height: 16, alignment: .center)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

