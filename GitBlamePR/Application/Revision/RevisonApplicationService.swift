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
    private var commitRepository = CommitRepositiry()
    private var prRepository = PullRequestRepository()
    private var sourceRepository = SourceRepository()

    init(fullPath: String, lineNumber: Int?) {
        viewModel = RevisionViewModel(commit: nil, pullRequest: nil, error: "")
        guard
            let path = FileFullPath(rawValue: fullPath),
            let lineNumber = lineNumber,
            let ln = LineNumber(lineNumber)
        else {
            return
        }
        sourceRepository.find(by: path) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let s):
                guard let line = s.line(by: ln) else {
                    self.viewModel.error = "Unknow error."
                    return
                }
                switch line.revision {
                case .commit(let sc):
                    do {
                        let commit = try self.commitRepository.find(byCommitHash: sc.hash, path: path)
                        self.viewModel = RevisionViewModel(commit: CommitViewModel(from: commit))
                        return
                    } catch let e {
                        self.viewModel.error = e.localizedDescription
                        return
                    }
                case .pullRequest(let pr):
                    self.prRepository.find(byNumber: pr.number, repositoryName: pr.repository.name, ownerName: pr.repository.ownerName) {[weak self] (result) in
                        self?.viewModel = RevisionViewModel(from: result)
                    }
                    return
                case .notCommited:
                    self.viewModel.error = "Not Commited."
                    return
                }
            case .failure(let e):
                self.viewModel.error = e.localizedDescription
                return
            }
        }
    }
}
