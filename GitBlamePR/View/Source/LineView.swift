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
    private var numberTextColor: Color {
        switch line.status {
        case .selected:
            return Color(NSColor.textBackgroundColor)
        case .none, .related:
            return .secondary
        }
    }
    private var codeTextColor: Color {
        switch line.status {
        case .selected:
            return Color(NSColor.textBackgroundColor)
        case .none, .related:
            return .primary
        }
    }
    private var revisionTextColor: Color {
        switch line.status {
        case .selected:
            return Color(NSColor.textBackgroundColor)
        case .none, .related:
            return .secondary
        }
    }
    private var background: some View {
        switch line.status {
        case .selected:
            return Color.accentColor
        case .related:
            return Color.accentColor.opacity(0.1)
        case .none:
            return Color.white.opacity(0.0001) // 0.0001 is workarround for ui event enable
        }
    }
    private let numberWidth: CGFloat = 34
    private let revisionWidth: CGFloat = 70
    private let space: CGFloat = 8
    private var codeWidth: CGFloat {
        max(width - numberWidth - revisionWidth - space * 2, 100)
    }

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: space) {
                Text(line.numberLabel)
                    .truncationMode(.head)
                    .foregroundColor(numberTextColor)
                    .lineLimit(1)
                    .frame(width: numberWidth, alignment: .trailing)
                Text(self.line.code)
                    .font(Font.system(.caption, design: .monospaced))
                    .foregroundColor(codeTextColor)
                    .frame(width: codeWidth, alignment: .leading)
                Text(line.revision.description)
                    .foregroundColor(revisionTextColor)
                    .fontWeight(.bold)
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
