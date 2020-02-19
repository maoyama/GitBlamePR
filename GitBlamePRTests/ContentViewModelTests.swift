//
//  ContentViewModelTests.swift
//  GitBlamePRTests
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import XCTest
@testable import GitBlamePR

class ContentViewModelTests: XCTestCase {
    let gitRemoteOutput = """
origin    git@github.com:kishikawakatsumi/SpreadsheetView.git (fetch)
origin    git@github.com:kishikawakatsumi/SpreadsheetView.git (push)
"""
    let gitBlamePROutput = """
^613e2c8,//
^613e2c8,//  CellRange.swift
^613e2c8,//  SpreadsheetView
^613e2c8,//
^613e2c8,//  Created by Kishikawa Katsumi on 3/16/17.
^613e2c8,//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
^613e2c8,//
^613e2c8,
^613e2c8,import UIKit
^613e2c8,
^613e2c8,public final class CellRange {
^613e2c8,    public let from: Location
^613e2c8,    public let to: Location
^613e2c8,
^613e2c8,    public let columnCount: Int
^613e2c8,    public let rowCount: Int
^613e2c8,
^613e2c8,    var size: CGSize?
^613e2c8,
^613e2c8,    public convenience init(from: (row: Int, column: Int), to: (row: Int, column: Int)) {
^613e2c8,        self.init(from: Location(row: from.row, column: from.column),
^613e2c8,                  to: Location(row: to.row, column: to.column))
^613e2c8,    }
^613e2c8,
PR #71   ,    public convenience init(from: IndexPath, to: IndexPath) {
PR #71   ,        self.init(from: Location(row: from.row, column: from.column),
PR #71   ,                  to: Location(row: to.row, column: to.column))
PR #71   ,    }
PR #71   ,
^613e2c8,    init(from: Location, to: Location) {
^613e2c8,        guard from.column <= to.column && from.row <= to.row else {
^613e2c8,            fatalError("the value of `from` must be less than or equal to the value of `to`")
^613e2c8,        }
^613e2c8,        self.from = from
^613e2c8,        self.to = to
^613e2c8,        columnCount = to.column - from.column + 1
^613e2c8,        rowCount = to.row - from.row + 1
^613e2c8,    }
^613e2c8,
^613e2c8,    public func contains(_ indexPath: IndexPath) -> Bool {
^613e2c8,        return  from.column <= indexPath.column && to.column >= indexPath.column &&
^613e2c8,            from.row <= indexPath.row && to.row >= indexPath.row
^613e2c8,    }
^613e2c8,
^613e2c8,    public func contains(_ cellRange: CellRange) -> Bool {
^613e2c8,        return from.column <= cellRange.from.column && to.column >= cellRange.to.column &&
^613e2c8,            from.row <= cellRange.from.row && to.row >= cellRange.to.row
^613e2c8,    }
^613e2c8,}
^613e2c8,
^613e2c8,extension CellRange: Hashable {
^613e2c8,    public var hashValue: Int {
^613e2c8,        return from.hashValue
^613e2c8,    }
^613e2c8,
^613e2c8,    public static func ==(lhs: CellRange, rhs: CellRange) -> Bool {
^613e2c8,        return lhs.from == rhs.from
^613e2c8,    }
^613e2c8,}
^613e2c8,
^613e2c8,extension CellRange: CustomStringConvertible, CustomDebugStringConvertible {
^613e2c8,    public var description: String {
^613e2c8,        return "R\\(from.row)C\\(from.column):R\\(to.row)C\\(to.column)"
^613e2c8,    }
^613e2c8,
^613e2c8,    public var debugDescription: String {
^613e2c8,        return description
^613e2c8,    }
^613e2c8,}
"""

    func testContentViewModelInit() {
        let vm = GitBlamePRViewModel(gitRemoteStandardOutput: gitRemoteOutput, gitBlamePRStandardOutput: gitBlamePROutput)!
        XCTAssertEqual(vm.lines.count, 69)
        XCTAssertEqual(vm.lines[24].message, "PR #71")
        XCTAssertEqual(vm.lines[24].url, URL(string: "https://github.com/kishikawakatsumi/SpreadsheetView/pull/71")!)
        XCTAssertEqual(vm.lines[24].code, "    public convenience init(from: IndexPath, to: IndexPath) {")

        XCTAssertEqual(vm.lines[28].message, "PR #71")
        XCTAssertEqual(vm.lines[28].code, "")
        XCTAssertEqual(vm.lines[59].message, "613e2c8")
        XCTAssertEqual(vm.lines[59].code, "")
    }
    
}
