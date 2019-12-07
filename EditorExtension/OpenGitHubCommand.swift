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
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

        // Retrieve the contents of the current source editor.
        let lines = invocation.buffer.lines
        // Reverse the order of the lines in a copy.
        let updatedText = Array(lines.reversed())
        lines.removeAllObjects()
        lines.addObjects(from: updatedText)
        // Signal to Xcode that the command has completed.

        completionHandler(nil)
    }
    
}
