//
//  OpenGitHubCommand.swift
//  EditorExtension
//
//  Created by Makoto Aoyama on 2019/12/07.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

import Foundation
import XcodeKit

class OpenGitHubCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
        connection.resume()
        let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol

        let semaphore = DispatchSemaphore(value: 0)
        xcode.upperCaseString("aaa") { (str) in
            invocation.buffer.lines.add(str!)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 10)
        invocation.buffer.lines.add("Hoge")
        
        connection.invalidate()
        completionHandler(nil)
    }
    
}
