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
    var lineOnSelect: ((commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?)) -> Void
    var lineOnSelect2: (_ lineNumber: Int) -> Void
    var rowPaddingH : CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            List {
                if !self.model.error.isEmpty {
                    Text(self.model.error)
                }
                ForEach(self.model.lines, id: \.number) { line in
                    LineView(
                        line: line,
                        width: geometry.frame(in: .local).size.width - self.rowPaddingH * 2
                    )
                        .onTapGesture {
                            self.lineOnSelect((commitHash: line.revision.commitHash, pullRequest: line.revision.pullRequest))
                            self.lineOnSelect2(line.number)
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
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "PR #2020", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "struct ContentView: View {",
                            number: 1,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "PR #2020", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "",
                            number: 2,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "    var body: some View {",
                            number: 3,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "-", pullRequest: nil, commitHash: nil),
                            url: nil,
                            code: "        GitBlamePRView(",
                            number: 4,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "fe21fe299", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            model: service.viewModel,",
                            number: 5,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            textOnCommit: {text in //xxxx xxxx xxxx xxxx xx xx xxx xxx xxx xxx Y",
                            number: 6,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "                self.service.fullPath = text",
                            number: 9999,
                            status: .none
                        ),
                        LineViewModel(
                            revision: SourceRevisionViewModel(description: "fe21fe29", pullRequest: nil, commitHash: nil),
                            url: URL(string: "https://github.com")!,
                            code: "            }",
                            number: 99999,
                            status: .none
                        ),
                    ]
                ),
                lineOnSelect: { _ in

            }, lineOnSelect2: {_ in }
            )
        }
    }
}
