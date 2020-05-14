//
//  RepositoryError.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/04.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import APIKit

struct RepositoryError: Error, LocalizedError {
    static var unknown = RepositoryError(localizedDescription: "Unknown error.")
    var localizedDescription: String
    var recoverySuggestion: String?
}

extension RepositoryError {
    init(from error: SessionTaskError) {
        switch error {
        case .connectionError(_):
            localizedDescription = "GitHubAPI Connection Error"
        case .requestError(_):
            localizedDescription = "GitHubAPI Request Error"
        case .responseError(let e as GitHubAPIError):
            localizedDescription = "GitHubAPI Error: \(e.statusCode ) " + e.message
            if e.statusCode == 404 || e.statusCode == 403 {
                // 404: Maybe a private repository
                // 403: Maybe rate limit
                recoverySuggestion = "You may need to authenticate with GitHub."
            }
        case .responseError(let e as ResponseError):
            switch e {
            case .nonHTTPURLResponse(_):
                localizedDescription = "GitHubAPI response that fails to down-cast "
            case .unexpectedObject(_):
                localizedDescription = "GitHubAPI response is unexpected."
            case .unacceptableStatusCode(let status):
                localizedDescription = "GitHubAPI Error: \(status) "  + HTTPURLResponse.localizedString(forStatusCode: status)
            }
        default:
            self = Self.unknown
        }
    }
}
