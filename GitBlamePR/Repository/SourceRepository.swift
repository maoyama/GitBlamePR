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

    func find(by path: FileFullPath, handler: @escaping (Result<Source, Error>) -> Void) {
        DispatchQueue.global().async {
            do {
                let remoteOut = try Git.remote(path: path)
                let blamePROut = try Git.blamePR(path: path)
                guard let source = Source(gitRemoteStandardOutput: remoteOut, gitBlamePRStandardOutput: blamePROut) else {
                    throw RepositoryError.unknown
                }
                DispatchQueue.main.async {
                    handler(.success(source))
                }
            } catch let e {
                DispatchQueue.main.async {
                    handler(.failure(e))
                }
            }
        }
    }

}
