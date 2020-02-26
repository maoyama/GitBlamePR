//
//  XcodeHelper.m
//  XcodeHelper
//
//  Created by Makoto Aoyama on 2020/02/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

#import "XcodeHelper.h"
#import "Xcode.h"

@implementation XcodeHelper

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
//    NSString *response = [aString uppercaseString];
//    reply(response);

    XcodeApplication *app = (XcodeApplication *)[SBApplication applicationWithBundleIdentifier: @"com.apple.dt.Xcode"];

    XcodeWorkspaceDocument *workspaceDocument = app.activeWorkspaceDocument;

    SBElementArray<XcodeProject *> *projects = workspaceDocument.projects;
    XcodeProject *project = projects.firstObject;

    SBElementArray<XcodeWindow *> * windows = app.windows;
    XcodeWindow *window = windows.firstObject;

    XcodeScheme *scheme = workspaceDocument.activeScheme;

    NSString *response = [NSString stringWithFormat:
                          @"Xcode name: %@\nworkspaceDocument.file: %@\nproject.name: %@\nwindow.name: %@\nscheme.name: %@",
                          app.name, workspaceDocument.file, project.name, window.name, scheme.name
                          ];
    reply(response);

}

@end
