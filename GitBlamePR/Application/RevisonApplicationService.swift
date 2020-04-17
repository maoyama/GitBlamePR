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

    init(commitHash: String, fullPathTextFieldValue: String) {
        self.commitRepository = CommitRepositiry()
        guard let fullPath = FileFullPath(rawValue: fullPathTextFieldValue) else {
            viewModel = RevisionViewModel(commit: nil, error: "Full path text error.")
            return
        }
        do {
            let commit = try commitRepository.find(byCommitHash: commitHash, directoryURL: fullPath.directoryURL)
            viewModel = RevisionViewModel(commit: CommitViewModel(from: commit), error:"")
            return
        } catch let e {
            print(e.localizedDescription)
            viewModel = RevisionViewModel(commit: nil, error: e.localizedDescription)
        }
    }
}
