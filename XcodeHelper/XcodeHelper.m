//
//  XcodeHelper.m
//  XcodeHelper
//
//  Created by Makoto Aoyama on 2019/12/08.
//  Copyright © 2019 dev.aoyama. All rights reserved.
//

#import "XcodeHelper.h"

@implementation XcodeHelper

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSTask *task = [[NSTask alloc] init];
    NSPipe *output = [[NSPipe alloc] init];
    NSPipe *error = [[NSPipe alloc] init];
    task.launchPath = @"/usr/bin/git";
    task.arguments = @[@"remote", @"-v"];
    task.currentDirectoryPath = @"/Users/aoyama/Projects/SpreadsheetView";
    task.standardOutput = output;
    task.standardError = error;
    [task launchAndReturnError:nil];
    NSString *outputstr = [[NSString alloc] initWithData: output.fileHandleForReading.readDataToEndOfFile encoding:NSUTF8StringEncoding];
    reply(outputstr);
}

@end
