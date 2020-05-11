//
//  SingleUserRequest.swift
//
//  Created by Makoto Aoyama on 2019/11/02.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation
import APIKit

struct PullRequestRequest: GitHubRequest {
    typealias Response = PullRequest

    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "repos/\(owner)/\(repos)/pulls/\(number)"
    }
    var owner: String
    var repos: String
    var number: Int
}
