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
        VStack(alignment: .leading, spacing: 8) {
            Text(model.hash).fontWeight(.bold)
            VStack(alignment: .leading) {
                Text("Author").foregroundColor(.gray).font(.caption)
                Text(model.author).fontWeight(.bold)
                Text(model.authorEmail)
                Text(model.authorDate)
            }
            VStack(alignment: .leading) {
                Text("Commit").foregroundColor(.gray).font(.caption)
                Text(model.committer).fontWeight(.bold)
                Text(model.committerEmail)
                Text(model.committerDate)
            }
            VStack(alignment: .leading) {
                Text(model.titleLine).fontWeight(.bold)
                Text(model.fullCommitMessage)
            }
            HStack{
                Spacer()
            }
            Spacer()
        }
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
                    authorDate: "6:15 AM · Apr 2, 2020",
                    committer: "Toru Aoyama",
                    committerEmail: "t@aoyama.dev",
                    committerDate: "7:15 PM · Apr 3, 2020",
                    titleLine: "title for commit",
                    fullCommitMessage: "message for commit.")
                )
                .frame(width: 200)
            CommitView(
                model: CommitViewModel(
                    hash: "ef12345",
                    author: "Makoto Aoyama",
                    authorEmail: "mmmmmmmmmmmmmmmm@aoyama.dev",
                    authorDate: "6:15 AM · Apr 2, 2020",
                    committer: "Toru Aoyama",
                    committerEmail: "t@aoyama.dev",
                    committerDate: "7:15 PM · Apr 3, 2020",
                    titleLine: "title for commit",
                    fullCommitMessage: "message for commit.")
                )
                .frame(width: 200, height: 300)
        }
    }
}

