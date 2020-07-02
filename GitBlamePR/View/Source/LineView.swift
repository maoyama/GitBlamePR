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
    @State var isHovered: Bool = false
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
            if isHovered {
                return Color.gray.opacity(0.2)
            }
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
                    self.isHovered = true
                } else {
                    self.isHovered = false
                }
            }
    }
}

struct LineView_Previews: PreviewProvider {
    static var model: LineViewModel {
        LineViewModel(
            revision: SourceRevisionViewModel(
                description: "#PR 1",
                pullRequest: (number: 1, owner: "owner", repository: "repo"),
                commitHash: "1e1e1e"
            ),
            url: nil,
            code: "print(hello)",
            number: 2,
            status: .none
        )
    }
    static var selected: LineViewModel {
        var m = model
        m.status = .selected
        return m
    }
    static var related: LineViewModel {
        var m = model
        m.status = .related
        return m
    }

    static var previews: some View {
        Group {
            Group {
                LineView(line: model, width: 300)
                LineView(line: selected, width: 300)
                LineView(line: related, width: 300)
            }
                .previewDisplayName("Light Mode")
                .background(Color(.windowBackgroundColor))
            Group {
                LineView(line: model, width: 300)
                LineView(line: selected, width: 300)
                LineView(line: related, width: 300)
            }
                .previewDisplayName("Dark Mode")
                .background(Color(.windowBackgroundColor))
                .environment(\.colorScheme, .dark)
        }
    }
}
