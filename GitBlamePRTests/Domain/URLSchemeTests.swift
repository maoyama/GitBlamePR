//
//  URLSchemeTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2020/03/01.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class URLSchemeTests: XCTestCase {
    func testFileFullPath() {
        let fullPath = "/Users/GitBlamePR/hoge.swift"
        let encodedFullPath = fullPath.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "hoge://\(encodedFullPath)")!

        guard let urlScheme = URLScheme(url:url) else {
            return XCTFail()
        }
        switch urlScheme {
        case .fileFullPath(let value):
            XCTAssertEqual(value.rawValue, fullPath)
        default:
            XCTFail()
        }
    }

    func testAccessToXcode() {
        let url = URL(string: "hoge://xcode/filefullpath")!

        guard let urlScheme = URLScheme(url:url) else {
            return XCTFail()
        }
        switch urlScheme {
        case .xcodeFileFullPath:
            break
        default:
            XCTFail()
        }
    }
}
