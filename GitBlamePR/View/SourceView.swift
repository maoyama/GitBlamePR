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
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    if !model.error.isEmpty {
                        Text(model.error)
                    }
                    ForEach(model.lines, id: \.number) { line in
                        HStack(alignment: .top, spacing: 12) {
                            if line.url == nil {
                                Text(line.revision.description)
                                    .font(Font.system(.caption, design: .monospaced))
                                    .foregroundColor(.gray)
                                    .frame(width: 100, height: nil, alignment: .trailing)
                                    .onTapGesture {
                                            NSWorkspace.shared.open(line.url!)
                                    }
                            } else {
                                Text(line.revision.description)
                                    .font(Font.system(.caption, design: .monospaced))
                                    .foregroundColor(.accentColor)
                                    .frame(width: 100, height: nil, alignment: .trailing)
                                    .onTapGesture {
                                            NSWorkspace.shared.open(line.url!)
                                    }
                                    .onHover { (enters) in
                                        if enters {
                                            self.revisionOnHover((commitHash: line.revision.commitHash, pullRequest: line.revision.pullRequest))
                                        }
                                    }
                            }
                            Text(line.code)
                                .font(Font.system(.caption, design: .monospaced))
                                .frame(width: nil, height: nil, alignment: .leading)
                        }
                    }
                    HStack {
                        Spacer()
                        EmptyView()
                    }
                }.padding()
            }.background(Color(NSColor.textBackgroundColor))
        }
    }
}

struct GitBlamePRView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SourceView(
                model: SourceViewModel(
                    lines: [
                        (
                            revision: SourceRevisionViewModel(description: "PR #2020", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "struct ContentView: View {",
                            number: 1
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "PR #2020", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "",
                            number: 2
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "    var body: some View {",
                            number: 3
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "Not Committed", pullRequest: nil, commitHash: nil),
                            url: nil,
                            code: "        GitBlamePRView(",
                            number: 4
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            model: service.viewModel,",
                            number: 5
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            textOnCommit: {text in",
                            number: 6
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "                self.service.fullPath = text",
                            number: 7
                        ),
                        (
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            }",
                            number: 8
                        ),
                    ]
                ),
                revisionOnHover: { _ in

                }
            )
        }
    }
}
