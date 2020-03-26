//
//  SourceView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/20.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit

struct SourceViewModel {
    var lines: [(message: String, url: URL?, code: String, id: UUID)]
    var recent: RecentViewModel
    var error = ""
}

struct SourceView: View {
    var model: SourceViewModel
    @State var fullPathTextFieldValue: String
    var textOnCommit: (String) -> Void
    var clearOnTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(
                "Enter full path",
                text: $fullPathTextFieldValue,
                onEditingChanged: {_ in },
                onCommit: {
                    self.textOnCommit(self.fullPathTextFieldValue)
                }
            ).lineLimit(1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Divider()
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    if !model.error.isEmpty {
                        Text(model.error)
                    }
                    if !model.recent.fullPaths.isEmpty {
                        RecentView(
                            model: model.recent,
                            textOnTap: { text in
                                self.fullPathTextFieldValue = text
                                self.textOnCommit(self.fullPathTextFieldValue)
                            },
                            clearOnTap: {
                                self.clearOnTap()
                            }
                        ).padding()
                    }
                    ForEach(model.lines, id: \.id) { line in
                        HStack(alignment: .top, spacing: 12) {
                            if line.url == nil {
                                Text(line.message)
                                    .font(Font.system(.caption, design: .monospaced))
                                    .foregroundColor(.gray)
                                    .frame(width: 100, height: nil, alignment: .trailing)
                                    .onTapGesture {
                                            NSWorkspace.shared.open(line.url!)
                                    }
                            } else {
                                Text(line.message)
                                    .font(Font.system(.caption, design: .monospaced))
                                    .foregroundColor(.accentColor)
                                    .frame(width: 100, height: nil, alignment: .trailing)
                                    .onTapGesture {
                                            NSWorkspace.shared.open(line.url!)
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
                            message: "PR #2020",
                            url: URL(string: "https://github.com")!,
                            code: "struct ContentView: View {",
                            id: UUID()
                        ),
                        (
                            message: "PR #2020",
                            url: URL(string: "https://github.com")!,
                            code: "",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "    var body: some View {",
                            id: UUID()
                        ),
                        (
                            message: "Not Committed",
                            url: nil,
                            code: "        GitBlamePRView(",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "            model: service.viewModel,",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "            textOnCommit: {text in",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "                self.service.fullPath = text",
                            id: UUID()
                        ),
                        (
                            message: "fe21fe29",
                            url: URL(string: "https://github.com")!,
                            code: "            }",
                            id: UUID()
                        ),
                    ],
                    recent: RecentViewModel(fullPaths: [])
                ),
                fullPathTextFieldValue: "",
                textOnCommit: {_ in },
                clearOnTap: {}

            )

            SourceView(
                model: SourceViewModel(
                    lines: [],
                    recent: RecentViewModel(fullPaths: [
                        (value: "/Users/aoyama/Dropbox/GitBlamePR/README.md", id: UUID())

                    ])
                ),
                fullPathTextFieldValue: "",
                textOnCommit: {_ in },
                clearOnTap: {}
            )
        }
    }
}
