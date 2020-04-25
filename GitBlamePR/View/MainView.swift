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
    private var error: String = ""
    @State private var path: String = ""
    @State private var revision: (commitHash: String?, pullRequest: (number: Int, owner: String, repository: String)?) = (commitHash: nil, pullRequest: nil)

    init(path: String="", error: String="") {
        self.path = path
        self.error = error
    }

    var body: some View {
        VStack {
            ToolBar(path: $path)
            SplitView(
                master: ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        if !error.isEmpty {
                            Text(error)
                        }
                        SourceViewWrapper(
                            service: SourceApplicationService(path: path),
                            revisionOnHover: { revision in
                                self.revision = revision
                        })
                        if path.isEmpty {
                            RecentViewWrapper() { path in
                                self.path = path
                            }
                        }
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
                }
            )
        }
    }
}
