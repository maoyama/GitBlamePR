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
                    LineView(line: line, revisionOnSelect: self.revisionOnHover, width: geometry.frame(in: .local).size.width - self.rowPaddingH * 2)
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
