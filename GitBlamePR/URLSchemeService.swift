//
//  URLSchemeService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/02/29.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class URLSchemeService {
    static func handle(url: URL, fileFullPath: @escaping(String) -> Void) {
        guard
            let urlScheme = URLScheme(url: url)
        else {
            return
        }
        switch urlScheme {
        case .fileFullPath(let value):
            fileFullPath(value)
            return
        case .accessToXcode:
            let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
            connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
            connection.resume()
            let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol
            let semaphore = DispatchSemaphore(value: 0)
            xcode.currentFileFullPath {(value) in
                semaphore.signal()
                DispatchQueue.main.async {
                    if let value = value {
                        fileFullPath(value)
                    }
                }
            }
            _ = semaphore.wait(timeout: .now() + 10)
            return
        }
    }
}
