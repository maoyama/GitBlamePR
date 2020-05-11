//
//  SourceRepository.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct SourceRepository {
    func find(by path: FileFullPath, handler: @escaping (Result<Source, Error>) -> Void) {
        if let source = SourceCache.shared.object(forKey: path) {
            handler(.success(source))
        }
        DispatchQueue.global().async {
            do {
                let remote = GitRemoteCommand(directoryURL: path.directoryURL)
                let blamePR = GitBlamePRCommand(path: path)
                let source = try Source(from: remote, command: blamePR)
                DispatchQueue.main.async {
                    handler(.success(source))
                    SourceCache.shared.set(source, forKey: path)
                }
            } catch let e {
                DispatchQueue.main.async {
                    handler(.failure(e))
                }
            }
        }
    }
}
