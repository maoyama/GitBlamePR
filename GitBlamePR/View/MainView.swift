//
//  MainView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import AppKit


struct MainView: View {
    @State var path: String = "" {
        didSet {
            self.error = ""
            self.line = nil
        }
    }
    @State var line: Int?
    @State var error: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ToolBar(path: $path)
            SplitView(
                master:
                VStack(alignment: .leading, spacing: 0) {
                    if !error.isEmpty {
                        Text(error)
                            .padding()
                        Divider()
                    }
                    if path.isEmpty {
                        ScrollView {
                            RecentViewWrapper() { path in
                                self.path = path
                            }
                            Spacer()
                        }
                    } else {
                        SourceViewWrapper(
                            service: SourceApplicationService(fullPath: path, lineNumber: line),
                            lineOnSelect: { line in
                                self.line = line
                        })
                    }
                }
                    .background(Color(NSColor.textBackgroundColor)),
                detail: ScrollView(.vertical) {
                    VStack {
                        RevisionViewWrapper(
                            service: RevisionApplicationService(
                                fullPath: path,
                                lineNumber: line
                            )
                        )
                        HStack {
                            Spacer()
                            EmptyView()
                        }
                    }
                }.background(Color(.windowBackgroundColor))
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(path: "/Users/aoyama/Dropbox/GitBlamePR/GitBlamePR/View/MainView.swift", error: "")
            MainView(path: "", error: "").environment(\.colorScheme, .light)
            MainView(path: "", error: "URL not found.").environment(\.colorScheme, .dark)
        }
    }
}
