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
        }
    }
    @State var revision: (commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?) = (commitHash: nil, pullRequest: nil)
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
                            service: SourceApplicationService(path: path),
                            revisionOnHover: { revision in
                                self.revision = revision
                        })
                    }
                }.background(Color(NSColor.textBackgroundColor)),
                detail: ScrollView(.vertical) {
                    VStack {
                        RevisionViewWrapper(
                            service: RevisionApplicationService(
                                commitHash: revision.commitHash,
                                pullRequestNumber: revision.pullRequest?.number,
                                pullRequestOwner: revision.pullRequest?.owner,
                                pullRequestRepositoryName: revision.pullRequest?.repository,
                                fullPathTextFieldValue: path
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
