//
//  PRTCMainWindowController.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/22.
//

#import "PRTCMainWindowController.h"
static NSString *const kPRTCMainWindowController = @"PRTCMainWindowController";


@interface PRTCMainWindowController ()



@end

@implementation PRTCMainWindowController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"-----%@ dealloc-------", self);
}
+ (instancetype)windowController{
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PRTCMainWindowController *main = [storyboard instantiateControllerWithIdentifier:kPRTCMainWindowController];
    // 设置动画样式
    [main.window setAnimationBehavior:NSWindowAnimationBehaviorDocumentWindow];
    return main;
}



- (void)windowDidLoad {
    [super windowDidLoad];
    [self configWindowFrameSize];
    [self.window center];
    [self.window setTitle:@"PRTC"];
    
}
- (void)configWindowFrameSize {
    NSRect frame = [[NSScreen mainScreen] visibleFrame];
    frame.size.height = 800;
    frame.size.width  = 1200;
    [self.window setFrame:frame display:YES];
}
@end
