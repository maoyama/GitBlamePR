//
//  XcodeConnection.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/15.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

struct XcodeConnection {
    // Request the ability to send Apple events & Get file full path on Xcode
    static func resume(fileFullPath: @escaping(FileFullPath?) -> Void) {
        let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
        connection.resume()
        let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol
        let semaphore = DispatchSemaphore(value: 0)
        xcode.currentFileFullPath {(value) in
            DispatchQueue.main.async {
                fileFullPath(FileFullPath(rawValue: value ?? ""))
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
