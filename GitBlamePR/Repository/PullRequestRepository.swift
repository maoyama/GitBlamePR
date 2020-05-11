//
//  PullRequestRepository.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/18.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import APIKit

struct PullRequestRepository {
    func find(byNumber number: Int, repositoryName: String,  ownerName: String, handler: @escaping (Result<PullRequest, RepositoryError>) -> Void) {
        let req = PullRequestRequest(owner: ownerName, repos: repositoryName, number: number)
        Session.send(req, handler: handler)
    }
}
