//
//  RevisonViewApplicationService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class RevisionApplicationService: ObservableObject {
    @Published private(set) var viewModel: RevisionViewModel
    private var commitRepository: CommitRepositiry
    private var prRepository: PullRequestRepository

    init(
        commitHash: String?,
        pullRequestNumber: Int?,
        pullRequestOwner: String?,
        pullRequestRepositoryName: String?,
        fullPathTextFieldValue: String
    ) {
        self.commitRepository = CommitRepositiry()
        self.prRepository = PullRequestRepository()
        guard let fullPath = FileFullPath(rawValue: fullPathTextFieldValue) else {
            viewModel = RevisionViewModel(commit: nil, error: "Full path text error.")
            return
        }
        viewModel = RevisionViewModel(commit: nil, pullRequest: nil, error: "")
        if let commitHash = commitHash {
            do {
                let commit = try commitRepository.find(byCommitHash: commitHash, directoryURL: fullPath.directoryURL)
                viewModel.commit = CommitViewModel(from: commit)
                return
            } catch let e {
                viewModel.error = e.localizedDescription
                return
            }
        }
        if let prNumber = pullRequestNumber,
            let prOwner = pullRequestOwner,
            let prRepositoryName = pullRequestRepositoryName {
            prRepository.find(byNumber: prNumber, repositoryName: prRepositoryName, ownerName: prOwner) {[weak self] (result) in
                switch result {
                case .success(let pr):
                    self?.viewModel.pullRequest = PullRequestViewModel(from: pr)
                case .failure(let e):
                    self?.viewModel.error = e.localizedDescription
                }
            }
        }
    }
}
