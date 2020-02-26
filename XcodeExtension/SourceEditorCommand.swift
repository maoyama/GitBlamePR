//
//  SourceEditorCommand.swift
//  XcodeExtension
//
//  Created by Makoto Aoyama on 2020/02/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        invocation.buffer.lines.add("Hoge")


        let connection = NSXPCConnection(serviceName: "dev.aoyama.XcodeHelper")
        connection.remoteObjectInterface = NSXPCInterface(with: XcodeHelperProtocol.self)
        connection.resume()
        let xcode = connection.remoteObjectProxy as! XcodeHelperProtocol

        let semaphore = DispatchSemaphore(value: 0)
        xcode.upperCaseString("aaaa") { (str) in
            invocation.buffer.lines.add(str!)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 10)

        completionHandler(nil)
    }
    
}
