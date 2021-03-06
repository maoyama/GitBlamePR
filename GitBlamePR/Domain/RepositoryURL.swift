//
//  RepositoryURL.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/19.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct Repository {
    var hostingSite: URL {
        URL(string: "https://github.com")!
    }
    var html: URL {
        hostingSite.appendingPathComponent(org).appendingPathComponent(repository)
    }
    let org: String
    let repository: String

    init?(gitRemoteStandardOutput: String) {
        guard let path = gitRemoteStandardOutput
            .components(separatedBy: .newlines)[0]
            .components(separatedBy: "github.com:")
            .last?
            .components(separatedBy: ".git")
            .first
            else {
                return nil
            }
        let pathComponents = path.components(separatedBy: "/")
        guard pathComponents.count == 2 else {
            return nil
        }
        self.org = pathComponents[0]
        self.repository = pathComponents[1]
    }
}
