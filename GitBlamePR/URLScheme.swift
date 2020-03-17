//
//  URLScheme.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/01.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

enum URLScheme {
    case fileFullPath(FileFullPath) // ://{fileFullPath}
    case xcodeFileFullPath    // ://xcode/filefullpath

    private static func xcodeFileFullPath(url:URL) -> URLScheme? {
        guard
            let host = url.host,
            host == "xcode",
            url.pathComponents.count == 2,
            url.pathComponents[1] == "filefullpath"
        else {
            return nil
        }
        return .xcodeFileFullPath
    }

    private static func makeFileFullPath(url:URL) -> URLScheme? {
        guard
            let fullPathRaw = url.host?.removingPercentEncoding,
            let fullPath = FileFullPath(rawValue: fullPathRaw),
            url.pathComponents.count == 0
        else {
            return nil
        }
        return .fileFullPath(fullPath)
    }

    init?(url:URL) {
        if let accessToXcode = Self.xcodeFileFullPath(url: url) {
            self = accessToXcode
            return
        }
        if let fileFullPath = Self.makeFileFullPath(url: url) {
            self = fileFullPath
            return
        }
        return nil
    }
}
