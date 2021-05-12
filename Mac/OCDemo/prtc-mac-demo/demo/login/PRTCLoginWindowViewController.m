//
//  PRTCLoginWindowViewController.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/29.
//

#import "PRTCLoginWindowViewController.h"
#import "AppDelegate.h"

static NSString *const kPRTCLoginWindowViewController = @"PRTCLoginWindowViewController";

@interface PRTCLoginWindowViewController ()

@end

@implementation PRTCLoginWindowViewController

- (void)windowDidLoad {
    [super windowDidLoad];
    
}


+ (instancetype)windowController{
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PRTCLoginWindowViewController *loginWC = [storyboard instantiateControllerWithIdentifier:kPRTCLoginWindowViewController];
    [loginWC.window setAnimationBehavior:NSWindowAnimationBehaviorDocumentWindow];
    return loginWC;
}

@end
