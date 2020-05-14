//
//  RevisionViewModel.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct RevisionViewModel {
    var commit: CommitViewModel? = nil
    var pullRequest: PullRequestViewModel? = nil
    var error = ""
}

extension RevisionViewModel {
    private init(from repoError: RepositoryError) {
        error = repoError.localizedDescription
        guard let recovery = repoError.recoverySuggestion else {
            return
        }
        error += "\n\n" + recovery
    }

    init(from result: Result<PullRequest, RepositoryError>) {
        switch result {
        case .success(let pr):
            self = Self(pullRequest: PullRequestViewModel(from: pr))
        case .failure(let e):
            self = Self(from: e)
        }
    }
}
