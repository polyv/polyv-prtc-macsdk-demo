//
//  PRTCDeviceTestWindowController.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/11.
//

#import "PRTCDeviceTestWindowController.h"

#import "PRTCDeviceTestController.h"

@interface PRTCDeviceTestWindowController ()





@end

@implementation PRTCDeviceTestWindowController

- (void)windowDidLoad {
    [super windowDidLoad];

    PRTCDeviceTestController *deviceTestController = [[PRTCDeviceTestController alloc] initWithNibName:@"PRTCDeviceTestController" bundle:nil];
    
    
    self.contentViewController = deviceTestController;
    
    
    
    
    
    
    
    
    
}








@end
