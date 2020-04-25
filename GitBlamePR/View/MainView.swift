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
                master: VStack {
                    if !error.isEmpty {
                        Text(error)
                    }
                    SourceViewWrapper(
                        service: SourceApplicationService(fullPath: path),
                        revisionOnHover: { revision in
                            self.revision = revision
                    })
                    if path.isEmpty {
                        RecentViewWrapper() { path in
                            self.path = path
                        }
                    }
                },
                detail: RevisionViewWrapper(
                    service: RevisionApplicationService(
                        commitHash: revision.commitHash ?? nil,
                        pullRequestNumber: revision.pullRequest?.number ?? nil,
                        pullRequestOwner: revision.pullRequest?.owner ?? nil,
                        pullRequestRepositoryName: revision.pullRequest?.repository ?? nil,
                        fullPathTextFieldValue: path
                    )
                )
            )
        }
    }
}
