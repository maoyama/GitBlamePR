//
//  CommitView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/29.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct CommitView: View {
    var model: CommitViewModel

    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleView(title: "Commit")
            VStack(alignment: .leading) {
                Text(model.titleLine)
                    .fontWeight(.bold)
                    .padding(.top, 4)
                    .contextMenu {
                            Button("Copy Title Line") {
                                NSPasteboard.setString(self.model.titleLine)
                            }
                    }

                if !model.fullCommitMessage.isEmpty {
                    Text(model.fullCommitMessage)
                        .padding(.top, 4)
                        .contextMenu {
                                Button("Copy Full Commit Message") {
                                    NSPasteboard.setString(self.model.fullCommitMessage)
                                }
                        }
                }

                Divider()
                    .padding(.bottom, 2)
                VStack(alignment: .leading) {
                    Text(model.author)
                    Text(model.authorEmail)
                        .foregroundColor(.secondary)
                    Text(model.authorDate)
                }
                Divider()
                    .padding(.bottom, 3)
                Text(model.hash)
                    .foregroundColor(.secondary)
                .contextMenu {
                        Button("Copy Commit Hash") {
                            NSPasteboard.setString(self.model.hash)
                        }
                }
                Divider()
                    .padding(.bottom, 3)
                if model.html != nil {
                    HStack {
                        Spacer()
                        Button("Open in GitHub") {
                            NSWorkspace.shared.open(self.model.html!)
                        }
                        Spacer()
                    }
                }
                HStack{
                    Spacer()
                }
                Spacer()
            }
            .padding(.init(top: 2, leading: 6, bottom: 6, trailing: 6))
        }
        .background(Color(.windowBackgroundColor))
        .padding(2)
    }
}


struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CommitView(
                model: CommitViewModel(
                    hash: "ef12345",
                    author: "Makoto Aoyama",
                    authorEmail: "m@aoyama.dev",
                    authorDate: "2020/04/20",
                    titleLine: "title for commit",
                    fullCommitMessage: "message for commit.",
                    html: URL(string: "https://example.com")
                )
                )
                .frame(width: 200)
            CommitView(
                model: CommitViewModel(
                    hash: "ef12345",
                    author: "Makoto Aoyama",
                    authorEmail: "mmmmmmmmmmmmmmmm@aoyama.dev",
                    authorDate: "2020/04/20",
                    titleLine: "Title for commit",
                    fullCommitMessage: "")
                )
                .frame(width: 200, height: 300)
        }
    }
}

