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
    NSString *response = [aString uppercaseString];
    reply(response);
}

@end
