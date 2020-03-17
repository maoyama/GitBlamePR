//
//  XcodeConnection.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/03/15.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation

enum XcodeConnectionError: Error {
    case fileNotFound
    case timedOut

    var localizedDescription: String {
        switch self {
        case .fileNotFound:
            return """
            File not found on Xcode.

            GitBlamePR.app needs access to control Xcode to get current open file.
            Please confirm "System Preference" > "Security & Privacy" > "Privacy" > "Automation" > "GitBlamePR.app" > "Xcode" checkbox.
            """
            case .timedOut:
            return "Xcode connection timed out."
        }
    }
}

struct XcodeConnection {
    // Request the ability to send Apple events & Get file full path on Xcode
    static func resume(fileFullPath: @escaping(Result<FileFullPath, XcodeConnectionError>) -> Void) {
        let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
        connection.resume()
        let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol
        let semaphore = DispatchSemaphore(value: 0)
        xcode.currentFileFullPath {(value) in
            DispatchQueue.main.async {
                if let value = value, let fullPath = FileFullPath(rawValue: value) {
                    fileFullPath(.success(fullPath))
                } else {
                    fileFullPath(.failure(.fileNotFound))
                }
            }
            semaphore.signal()
        }
        let result = semaphore.wait(timeout: .now() + 10)
        switch result {
        case .success:
            break;
        case .timedOut:
            fileFullPath(.failure(.timedOut))
        }
        return
    }
}
