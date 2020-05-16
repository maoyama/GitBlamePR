//
//  LineView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/11.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct LineView: View {
    var line: (revision: SourceRevisionViewModel, url: URL?, code: String, number: String)
    var width: CGFloat
    var selected: Bool
    var related: Bool
    var numberTextColor: Color {
        selected ? Color(NSColor.textBackgroundColor) : .secondary
    }
    var codeTextColor: Color {
        selected ? Color(NSColor.textBackgroundColor) : .primary
    }
    var revisionTextColor: Color {
        selected ? Color(NSColor.textBackgroundColor) : .secondary
    }
    var background: some View {
        if selected {
             return Color.blue

        }
        if related {
            return Color(NSColor.windowBackgroundColor)
        }
        return Color(NSColor.textBackgroundColor)
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
                Text(line.number)
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
