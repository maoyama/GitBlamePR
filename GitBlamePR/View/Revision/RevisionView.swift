//
//  RevisionView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/05/14.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI

struct RevisionView: View {
    var model: RevisionViewModel
    var body: some View {
        VStack(alignment: .leading) {
            if !model.error.isEmpty {
                HStack {
                    Text(model.error)
                    Spacer()
                }
                    .padding(.init(top: 16, leading: 10, bottom: 16, trailing: 10))

                Spacer()
            }
            if model.commit != nil {
                CommitView(model: model.commit!)
            }
            if model.pullRequest != nil {
                PullRequestView(model: model.pullRequest!)
            }
        }
    }
}

struct RevisionView_Previews: PreviewProvider {
    static var previews: some View {
        RevisionView(model: RevisionViewModel(commit: nil, pullRequest: nil, error: "hoge"))
            .frame(width: 300, height: 400)
    }
}
