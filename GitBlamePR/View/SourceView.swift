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

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if !model.error.isEmpty {
                Text(model.error)
            }
            ForEach(model.lines, id: \.number) { line in
                LineView(line: line, revisionOnHover: self.revisionOnHover)
            }
            HStack {
                Spacer()
                EmptyView()
            }
        }.padding()
    }
}

struct LineView: View {
    var line: (revision: SourceRevisionViewModel, url: URL?, code: String, number: String)
    var revisionOnHover: ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Text(line.number)
                    .font(Font.system(.caption, design: .monospaced))
                    .foregroundColor(.gray)
                    .opacity(0.8)
                    .frame(width: 20, alignment: .trailing)


                Text(line.code)
                    .font(Font.system(.caption, design: .monospaced))

                Spacer()
                if line.url == nil {// e.g. Not commited
                    Text(line.revision.description)
                        .font(Font.system(.caption, design: .monospaced))
                        .foregroundColor(.gray)
                        .frame(width: 100, alignment: .leading)
                } else {
                    Text(line.revision.description)
                        .font(Font.system(.caption, design: .monospaced))
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                        .frame(width: 100, height: nil, alignment: .leading)
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
                            code: "            textOnCommit: {text in",
                            number: "6"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "                self.service.fullPath = text",
                            number: "7"
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            }",
                            number: "8"
                        ),
                    ]
                ),
                revisionOnHover: { _ in

                }
            )
        }
    }
}
