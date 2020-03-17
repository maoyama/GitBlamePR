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
- (void)currentFileFullPath:(void (^)(NSString *))reply {
        XcodeApplication *app = (XcodeApplication *)[SBApplication applicationWithBundleIdentifier: @"com.apple.dt.Xcode"];
        SBElementArray<XcodeWindow *> * windows = app.windows;
        NSString *currentFileName = windows.firstObject.name;
        __block NSString *currentFilePath = @"";
        [app.sourceDocuments enumerateObjectsUsingBlock:^(XcodeSourceDocument * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[[obj.path componentsSeparatedByString:@"/"] lastObject] isEqualToString:currentFileName]) {
                currentFilePath = obj.path;
            }
        }];
        reply(currentFilePath);
}


@end

