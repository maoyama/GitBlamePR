//
//  Session+SendTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/05/13.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR
@testable import APIKit

class Session_SendTests: XCTestCase {
    func testGitHubAPIError() throws {
        let expection = expectation(description: "")
        let privateRepoRequest = PullRequestRequest(owner: "maoyama", repos: "Hangar", number: 9)
        Session.send(privateRepoRequest) {
            switch $0 {
            case .success(_):
                XCTFail()
            case .failure(let e):
                XCTAssertEqual(e.recoverySuggestion!, "You may need to authenticate with GitHub.")
            }
            expection.fulfill()
        }
        wait(for: [expection], timeout: 1)
    }
}
