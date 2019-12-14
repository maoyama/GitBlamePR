//
//  XcodeHelper.m
//  XcodeHelper
//
//  Created by Makoto Aoyama on 2019/12/08.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

#import "XcodeHelper.h"
#import "Xcode.h"

@implementation XcodeHelper

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {

    XcodeApplication *app = [SBApplication applicationWithBundleIdentifier: @"com.apple.dt.Xcode"];

    XcodeWorkspaceDocument *workspaceDocument = app.activeWorkspaceDocument;

    SBElementArray<XcodeProject *> *projects = workspaceDocument.projects;
    XcodeProject *project = projects.firstObject;

    SBElementArray<XcodeWindow *> * windows = app.windows;
    XcodeWindow *window = windows.firstObject;

    XcodeScheme *scheme = workspaceDocument.activeScheme;

    NSString *response = [NSString stringWithFormat:
                          @"Xcode version: %@\nworkspaceDocument.file: %@\nproject.name: %@\nwindow.name: %@\nscheme.name: %@",
                          app.version, workspaceDocument.file, project.name, window.name, scheme.name
                          ];
    reply(response);
//    NSTask *task = [[NSTask alloc] init];
//    NSPipe *output = [[NSPipe alloc] init];
//    NSPipe *error = [[NSPipe alloc] init];
//    task.launchPath = @"/usr/bin/git";
//    task.arguments = @[@"remote", @"-v"];
//    task.currentDirectoryPath = @"/Users/aoyama/Projects/SpreadsheetView";
//    task.standardOutput = output;
//    task.standardError = error;
//    [task launchAndReturnError:nil];
//    NSString *outputstr = [[NSString alloc] initWithData: output.fileHandleForReading.readDataToEndOfFile encoding:NSUTF8StringEncoding];
//    reply(outputstr);
}

@end
