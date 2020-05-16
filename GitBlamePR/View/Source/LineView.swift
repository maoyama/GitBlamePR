//
//  LineView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct LineView: View {
    var line: LineViewModel
    var width: CGFloat
    var numberTextColor: Color {
        switch line.status {
        case .selected:
            return Color(NSColor.textBackgroundColor)
        case .none, .related:
            return.secondary
        }
    }
    var codeTextColor: Color {
        switch line.status {
        case .selected:
            return Color(NSColor.textBackgroundColor)
        case .none, .related:
            return .primary
        }
    }
    var revisionTextColor: Color {
        switch line.status {
        case .selected:
            return Color(NSColor.textBackgroundColor)
        case .none, .related:
            return .secondary
        }
    }
    var background: some View {
        switch line.status {
        case .selected:
            return Color.blue
        case .related:
            return Color(NSColor.windowBackgroundColor)
        case .none:
            return Color(NSColor.textBackgroundColor)
        }
    }
    var numberWidth: CGFloat = 34
    var revisionWidth: CGFloat = 70
    var space: CGFloat = 8
    var codeWidth: CGFloat {
        max(width - numberWidth - revisionWidth - space * 2, 100)
    }

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: space) {
                Text("\(line.number)")
                    .truncationMode(.head)
                    .foregroundColor(numberTextColor)
                    .opacity(0.8)
                    .lineLimit(1)
                    .frame(width: numberWidth, alignment: .trailing)
                Text(self.line.code)
                    .font(Font.system(.caption, design: .monospaced))
                    .foregroundColor(codeTextColor)
                    .frame(width: codeWidth, alignment: .leading)
                Text(line.revision.description)
                    .foregroundColor(revisionTextColor)
                    .fontWeight(.bold)
                    .opacity(0.8)
                    .lineLimit(1)
                    .frame(width: revisionWidth, alignment: .leading)
            }
        }
            .font(Font.system(size: 12, weight: .regular, design: .monospaced))
            .lineSpacing(9)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            .onHover { (enter) in
                if (enter) {
                    NSCursor.pointingHand.set()
                } else {
                    NSCursor.arrow.set()
                }
            }
    }
}
