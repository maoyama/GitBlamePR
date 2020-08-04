//
//  PullRequestView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/03.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct PullRequestView: View {
    var model: PullRequestViewModel
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleView(title: "Pull Request")
            VStack(alignment: .leading) {
                Group {
                    Text(model.title)
                            .fontWeight(.bold)
                    + Text(" " + model.number )
                    .foregroundColor(.secondary)
                }
                    .padding(.top, 4)
                    .contextMenu {
                        Button("Copy Title") {
                            NSPasteboard.setString(self.model.title)
                        }
                        Button("Copy Number") {
                            NSPasteboard.setString(self.model.number)
                        }
                    }

                if !model.body.isEmpty {
                    Group {
                        Text(model.body)
                    }
                        .padding(.top, 4)
                        .contextMenu {
                            Button("Copy") {
                                NSPasteboard.setString(self.model.body)
                            }
                        }
                }

                Author(
                    userAvatarURL: model.userAvatarURL,
                    user: model.user,
                    mergedAt: model.mergedAt)
                Divider()
                    .padding(.bottom, 3)
                Counter(
                    conversationCount: model.conversationCount,
                    commitsCount: model.commitsCount,
                    changedFiles: model.changedFiles,
                    additionsCount: model.additionsCount,
                    deletionsCount: model.deletionsCount
                )
                Divider()
                    .padding(.bottom, 3)
                HStack {
                    Spacer()
                    Button("Open in GitHub") {
                        NSWorkspace.shared.open(self.model.html)
                    }
                    Spacer()
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

private struct Author: View {
    var userAvatarURL: URL
    var user: String
    var mergedAt: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                KFImage(userAvatarURL)
                    .cancelOnDisappear(true)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                VStack (alignment: .leading) {
                    Text(user)
                    Text(mergedAt).foregroundColor(.secondary)
                        .font(.system(size: 11))
                }
                    .padding(.top, -2)
                Spacer()
            }
        }
    }
}

private struct Counter: View {
    var conversationCount: String
    var commitsCount: String
    var changedFiles: String
    var additionsCount: String
    var deletionsCount: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(conversationCount).fontWeight(.bold)
                Text("Conversation").foregroundColor(.secondary).font(.caption)
            }
            HStack {
                Text(commitsCount).fontWeight(.bold)
                Text("Commits").foregroundColor(.secondary).font(.caption)
            }
            HStack {
                Text(changedFiles).fontWeight(.bold)
                Text("File changed").foregroundColor(.secondary).font(.caption)
            }
            HStack {
                Text(additionsCount).foregroundColor(.green)
                Text(deletionsCount).foregroundColor(.red)
            }
        }
    }
}

struct PullRequestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
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
            )
                .frame(width: 200)
                .environment(\.colorScheme, .light)

            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
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
            .environment(\.colorScheme, .dark)

            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "",
                    user: "Maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "2020/04/20",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            ).frame(width: 250)
            .environment(\.colorScheme, .dark)

        }
    }
}

