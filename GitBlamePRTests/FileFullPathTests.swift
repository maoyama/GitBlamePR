//
//  FileFullPathTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/03/15.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class FileFullPathTests: XCTestCase {
    func testInit() {
        let fullPath = FileFullPath(rawValue: "")
        XCTAssertNil(fullPath)
    }

    func testRawValue() {
        let fullPath = FileFullPath(rawValue: "/Users/aoyama/Dropbox/hoge.txt")
        XCTAssertEqual(fullPath!.rawValue, "/Users/aoyama/Dropbox/hoge.txt")
    }

    func testTrimmed() {
        let fullPath = FileFullPath(rawValue: " /Users/aoyama/Dropbox/hoge.txt  ")
        XCTAssertEqual(fullPath!.trimmed, "/Users/aoyama/Dropbox/hoge.txt")
    }

    func testDirectoryURL() {
        let fullPath = FileFullPath(rawValue: " /Users/aoyama/Dropbox/hoge.txt  ")
        XCTAssertEqual(fullPath!.directoryURL, URL(string: "file:///Users/aoyama/Dropbox/")!)
    }
}
