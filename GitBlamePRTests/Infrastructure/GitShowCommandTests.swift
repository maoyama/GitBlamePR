//
//  GitShowCommandTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/04/16.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class GitShowCommandTests: XCTestCase {

    func testOutput() {
        let hash = "3e8a2eb172cefce4d28301ccc0df687926e3a0e4"
        let command = GitShowCommand(
            commitHash: hash,
            directoryURL: Enviroment.sourceRootDirectory
        )
        let commit = try! Commit(from: command, command: GitRemoteCommand(directoryURL: Enviroment.sourceRootDirectory))
        XCTAssertEqual(commit.hash, hash)
        XCTAssertEqual(commit.author, "Makoto Aoyama")
        XCTAssertEqual(commit.authorEmail, "m@aoyama.dev")
        XCTAssertEqual(commit.authorDate, ISO8601DateFormatter().date(from: "2020-03-26T23:09:47+09:00")!)
        XCTAssertEqual(commit.committer, "GitHub")
        XCTAssertEqual(commit.committerEmail, "noreply@github.com")
        XCTAssertEqual(commit.authorDate, ISO8601DateFormatter().date(from: "2020-03-26T23:09:47+09:00")!)
        XCTAssertEqual(commit.titleLine, "Merge pull request #17 from maoyama/fix-not-commited")
        XCTAssertEqual(commit.fullCommitMessage, "Fix git blame pr command failure when not commited")
    }

    func testOutputEmptyFullCommitMessage() throws {
        let hash = "bf97c67"
        let command = GitShowCommand(
            commitHash: hash,
            directoryURL: Enviroment.sourceRootDirectory
        )
        let commit = try! Commit(from: command, command: GitRemoteCommand(directoryURL: Enviroment.sourceRootDirectory))
        XCTAssertEqual(commit.fullCommitMessage, "")
    }

    func testOutputMultiLineFullCommitMessage() throws {
        let hash = "0de786030b6a1150815fdfbe37aa708025081769"
        let command = GitShowCommand(
            commitHash: hash,
            directoryURL: Enviroment.sourceRootDirectory
        )
        let commit = try! Commit(from: command, command: GitRemoteCommand(directoryURL: Enviroment.sourceRootDirectory))
        XCTAssertEqual(
            commit.fullCommitMessage, """
This reverts commit 44cd166895ac93832525f3f7eca6b7e1fef8fe3d, reversing
changes made to 85f33ba2369535a559a0506e3a9d6a8ddf68a8e7.

"""
        )
    }
}
