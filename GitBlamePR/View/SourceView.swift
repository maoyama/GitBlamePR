//
//  SourceView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit

struct SourceView: View {
    var model: SourceViewModel
    var revisionOnHover: ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void
    var rowPaddingH : CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            List {
                if !self.model.error.isEmpty {
                    Text(self.model.error)
                }
                ForEach(self.model.lines, id: \.number) { line in
                    LineView(line: line, revisionOnHover: self.revisionOnHover, width: geometry.frame(in: .local).size.width - self.rowPaddingH * 2)
                }
            }
        }
    }
}

struct LineView: View {
    var line: (revision: SourceRevisionViewModel, url: URL?, code: String, number: String)
    var revisionOnHover: ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void
    var width: CGFloat
    var numberWidth: CGFloat = 30
    var revisionWidth: CGFloat = 90
    var space: CGFloat = 8
    var codeWidth: CGFloat {
        max(width - numberWidth - revisionWidth - space * 2, 100)
    }

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: space) {
                Text(line.number)
                    .font(Font.system(.caption, design: .monospaced)).truncationMode(.head)
                    .foregroundColor(.secondary)
                    .opacity(0.8)
                    .lineLimit(1)
                    .frame(width: numberWidth, alignment: .trailing)
                Text(self.line.code)
                    .font(Font.system(.caption, design: .monospaced))
                    .frame(width: codeWidth, alignment: .leading)
                if line.url == nil {// e.g. Not commited
                    Text(line.revision.description)
                        .lineLimit(1)
                        .font(Font.system(.caption, design: .monospaced))
                        .foregroundColor(.gray)
                        .frame(width: revisionWidth, alignment: .leading)
                } else {
                    Text(line.revision.description)
                        .font(Font.system(.caption, design: .monospaced))
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(width: revisionWidth, height: nil, alignment: .leading)
                        .onTapGesture {
                            NSWorkspace.shared.open(self.line.url!)
                        }
                        .onHover { (enters) in
                            if enters {
                                self.revisionOnHover((commitHash: self.line.revision.commitHash, pullRequest: self.line.revision.pullRequest))
                            }
                        }
                }

            }
        }
    }
}

struct Source_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SourceView(
                model: SourceViewModel(
                    lines: [
                        (
                            revision: SourceRevisionViewModel(description: "PR #2020", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "struct ContentView: View {",
                            number: "1"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "PR #2020", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "",
                            number: "2"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "    var body: some View {",
                            number: "3"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "Not Committed", pullRequest: nil, commitHash: nil),
                            url: nil,
                            code: "        GitBlamePRView(",
                            number: "4"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            model: service.viewModel,",
                            number: "5"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            textOnCommit: {text in //xxxx xxxx xxxx xxxx xx xx xxx",
                            number: "6"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "                self.service.fullPath = text",
                            number: "9999"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            }",
                            number: "99999"
                        ),
                    ]
                ),
                revisionOnHover: { _ in

            }
            )
        }
    }
}
