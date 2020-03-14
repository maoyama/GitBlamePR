//
//  URLScheme.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/01.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

enum URLScheme {
    case fileFullPath(String) // ://{fileFullPath}
    case xcodeFileFullPath    // ://xcode/filefullpath  Request the ability to send Apple events & Get file full path on Xcode

    private static func makeAccessToXcode(url:URL) -> URLScheme? {
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
            let fullPath = url.host?.removingPercentEncoding,
            url.pathComponents.count == 0
        else {
            return nil
        }
        return .fileFullPath(fullPath)
    }

    init?(url:URL) {
        if let accessToXcode = Self.makeAccessToXcode(url: url) {
            self = accessToXcode
            return
        }
        if let fileFullPath = Self.makeFileFullPath(url: url) {
            self = fileFullPath
            return
        }
        return nil
    }

    func handle(fileFullPath: @escaping(String?) -> Void) {
        switch self {
        case .fileFullPath(let value):
            fileFullPath(value)
            return
        case .xcodeFileFullPath:
            let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
            connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
            connection.resume()
            let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol
            let semaphore = DispatchSemaphore(value: 0)
            xcode.currentFileFullPath {(value) in
                DispatchQueue.main.async {
                    fileFullPath(value)
                }
                semaphore.signal()
            }
            let result = semaphore.wait(timeout: .now() + 10)
            switch result {
            case .success:
                break;
            case .timedOut:
                fileFullPath(nil)
            }
            return
        }
    }
}
