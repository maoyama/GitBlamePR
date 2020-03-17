//
//  XcodeHelper.h
//  XcodeHelper
//
//  Created by Makoto Aoyama on 2020/02/22.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XcodeHelperProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XcodeHelper : NSObject <XcodeHelperProtocol>
@end
