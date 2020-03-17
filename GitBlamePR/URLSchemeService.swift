//
//  URLSchemeService.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/02/29.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

class URLSchemeService {
    static func handle(url: URL, fileFullPath: @escaping(String?) -> Void) {
        guard
            let urlScheme = URLScheme(url: url)
        else {
            fileFullPath(nil)
            return
        }
        switch urlScheme {
        case .fileFullPath(let value):
            fileFullPath(value)
            return
        case .accessToXcode: // Request the ability to send Apple events & Get file full path on Xcode
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
