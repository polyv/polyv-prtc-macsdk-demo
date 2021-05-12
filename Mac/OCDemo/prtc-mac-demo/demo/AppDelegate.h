//
//  AppDelegate.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/1/20.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) IBOutlet NSWindow *window;


// 强引用窗口控制器
@property (strong) NSWindowController *mainWindowController;

@end

