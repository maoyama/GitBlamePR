//
//  PullRequestView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/03.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PullRequestViewModel {
    var htmlURL: URL
    var number: String
    var title: String
    var body: String
    var user: String
    var userAvatarURL: URL
    var mergedAt: String
    var conversationCount: String
    var commitsCount: String
    var changedFiles: String
    var additionsCount: String
    var deletionsCount: String
}

struct PullRequestView: View {
    var model: PullRequestViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text(model.title + " - " + model.number )
                        .fontWeight(.bold)
                HStack {
                    KFImage(model.userAvatarURL)
                        .cancelOnDisappear(true)
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 20, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    Text(model.user)
                    Spacer()
                    Text(model.mergedAt).foregroundColor(.gray)
                }
                Text(model.body)

            }
            VStack(alignment: .leading) {
                HStack {
                    Text(model.conversationCount).fontWeight(.bold)
                    Text("Conversation").foregroundColor(.gray).font(.caption)
                }
                HStack {
                    Text(model.commitsCount).fontWeight(.bold)
                    Text("Commits").foregroundColor(.gray).font(.caption)
                }
                HStack {
                    Text(model.changedFiles).fontWeight(.bold)
                    Text("File changed").foregroundColor(.gray).font(.caption)
                }
                HStack {
                    Text(model.additionsCount).foregroundColor(.green)
                    Text(model.deletionsCount).foregroundColor(.red)
                }
            }
            HStack{
                Spacer()
            }
            Spacer()
        }
    }
}

struct PullRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestView(model:
            PullRequestViewModel(
                htmlURL: URL(string: "https://example.com")!,
                number: "#17",
                title: "Fix git blame pr command failure when not commited",
                body: "GitBlamePR.app bundles Xcode Source Editor Extension.Files opened in Xcode can be easily opened in GitBlamePR.app.I recommend that you set a key binding for this function.",
                user: "maoyama",
                userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                mergedAt: "8 days ago",
                conversationCount: "10",
                commitsCount: "7",
                changedFiles: "8",
                additionsCount: "+283",
                deletionsCount: "-130"
            )
        ).frame(width: 200)
    }
}
