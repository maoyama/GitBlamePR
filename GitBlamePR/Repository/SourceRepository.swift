//
//  SourceRepository.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct SourceRepository {
    func find(by path: FileFullPath) throws -> Source {
        let remoteOut = try Git.remote(path: path)
        let blamePROut = try Git.blamePR(path: path)
        guard let source = Source(gitRemoteStandardOutput: remoteOut, gitBlamePRStandardOutput: blamePROut) else {
            throw RepositoryError.unknown
        }
        return source
    }
}
