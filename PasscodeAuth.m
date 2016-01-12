#import "PasscodeAuth.h"
#import "RCTUtils.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation PasscodeAuth

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(isSupported: (RCTResponseSenderBlock)callback)
{

    if (![self supportsPasscodeAuth]) {
        callback(@[RCTMakeError(@"PasscodeAuthNotSupported", nil, nil)]);
        return;
    }

    LAContext *context = [[LAContext alloc] init];

    // Check if PasscodeAuth Authentication is available
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
        callback(@[[NSNull null], @true]);
    // PasscodeAuth is not set
    } else {
        callback(@[RCTMakeError(@"PasscodeAuthNotSet", nil, nil)]);
        return;
    }

}

RCT_EXPORT_METHOD(authenticate: (NSString *)reason
                  callback: (RCTResponseSenderBlock)callback)
{
    if (![self supportsPasscodeAuth]) {
        callback(@[RCTMakeError(@"PasscodeAuthNotSupported", nil, nil)]);
        return;
    }

    LAContext *context = [[LAContext alloc] init];
    NSError *error;

    // Device has PasscodeAuth
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        // Attempt Authentication
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                localizedReason:reason
                          reply:^(BOOL success, NSError *error)
         {
             // Failed Authentication
             if (error) {
                 NSString *errorReason;

                 switch (error.code) {
                     case LAErrorAuthenticationFailed:
                         errorReason = @"LAErrorAuthenticationFailed";
                         break;

                     case LAErrorUserCancel:
                         errorReason = @"LAErrorUserCancel";
                         break;

                     case LAErrorUserFallback:
                         errorReason = @"LAErrorUserFallback";
                         break;

                     case LAErrorSystemCancel:
                         errorReason = @"LAErrorSystemCancel";
                         break;

                     case LAErrorPasscodeNotSet:
                         errorReason = @"LAErrorPasscodeNotSet";
                         break;

                     default:
                         errorReason = @"PasscodeAuthUnknownError";
                         break;
                 }

                 NSLog(@"Authentication failed: %@", errorReason);
                 callback(@[RCTMakeError(errorReason, nil, nil)]);
                 return;
             }

             // Authenticated Successfully
             callback(@[[NSNull null], @"Authenticated with PasscodeAuth."]);
         }];

    // Device does not support PasscodeAuth
    } else {
        callback(@[RCTMakeError(@"PasscodeAuthNotSet", nil, nil)]);
        return;
    }
}

- (BOOL)supportsPasscodeAuth {
    // PasscodeAuth is only available in iOS 9.  In iOS8, `LAPolicyDeviceOwnerAuthentication` is present but not implemented.
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];

    return osVersion >= 9.0;
}


@end
