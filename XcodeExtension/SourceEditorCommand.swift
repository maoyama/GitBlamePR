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
        
        completionHandler(nil)
    }
    
}
