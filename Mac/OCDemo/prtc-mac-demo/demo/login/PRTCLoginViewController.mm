//
//  PRTCLoginViewController.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/8.
//

#import "PRTCLoginViewController.h"
#import "PRTCMainWindowController.h"
#import "PRTCSettingWindowController.h"
#import "PRTCDeviceTestWindowController.h"
#import "PRTCConfigModel.h"
#import "PRTCMainViewController.h"
#import "AppDelegate.h"



#include <string>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>


#import <sys/utsname.h>
#include <sys/sysctl.h>
#include <mach/mach_host.h>
#include <mach/task.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface PRTCLoginViewController ()

@property (weak) IBOutlet NSTextField *userIdTextfield;
@property (weak) IBOutlet NSTextField *roomIdTextfield;
@property (weak) IBOutlet NSButton *settingBtn;

@property(strong) PRTCConfigModel *config;

@property(strong, nonatomic) PRTCSettingWindowController *settingWindowController;
@property(strong, nonatomic) PRTCMainWindowController *mainWindowController;
@property(strong, nonatomic) PRTCDeviceTestWindowController *deviceTestWindowController;
@end

@implementation PRTCLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _config = [PRTCConfigModel new];

}



- (IBAction)joinChannel:(NSButton *)sender {
    if (_userIdTextfield.stringValue.length <= 0) {
        NSLog(@"请输入用户id");
        return;
    }

    if (_roomIdTextfield.stringValue.length <= 0) {
        NSLog(@"请输入房间id");
        return;
    }

    if (_settingWindowController.window.isVisible) {
        [_settingWindowController.window orderOut:nil];
    }

    if (_deviceTestWindowController.window.isVisible) {
        [_deviceTestWindowController.window orderOut:nil];
    }
    
    
    PRTCMainWindowController *mainWindowController = [PRTCMainWindowController windowController];
    PRTCMainViewController *mainViewController = (PRTCMainViewController *)mainWindowController.contentViewController;
    mainViewController.roomId = _roomIdTextfield.stringValue;
    mainViewController.userId = _userIdTextfield.stringValue;
    mainViewController.config = _config;
   
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApplication sharedApplication].delegate;
    appDelegate.mainWindowController = mainWindowController;
    [mainWindowController.window makeKeyAndOrderFront:self];
    
    [self.view.window orderOut:self];
    
}

- (IBAction)doSetting:(NSButton *)sender {
    if (_settingWindowController.window.isVisible) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    self.settingWindowController.settingComplete = ^(PRTCConfigModel * _Nonnull config) {
        weakSelf.config = config;
    };

    [self.settingWindowController.window orderFront:nil];
    
}

- (IBAction)doTestDevice:(NSButton *)sender {
    if (_deviceTestWindowController.window.isVisible) {
        return;
    }
    
    [self.deviceTestWindowController.window orderFront:nil];

}




- (PRTCMainWindowController *)mainWindowController {
    if (!_mainWindowController) {
        _mainWindowController =  [[PRTCMainWindowController alloc] initWithWindowNibName:NSStringFromClass([PRTCMainWindowController class])];
    }
    return _mainWindowController;
}


- (PRTCSettingWindowController *)settingWindowController {
    if (!_settingWindowController) {
        _settingWindowController = [[PRTCSettingWindowController alloc] initWithWindowNibName:@"PRTCSettingWindowController"];
    }
    return _settingWindowController;
}


- (PRTCDeviceTestWindowController *)deviceTestWindowController {
    if (!_deviceTestWindowController) {
        _deviceTestWindowController = [[PRTCDeviceTestWindowController alloc] initWithWindowNibName:@"PRTCDeviceTestWindowController"];
    }
    return _deviceTestWindowController;
}


- (IBAction)closeWindow:(NSButton *)sender {
    exit(0);

}





#pragma mark------------------------------test

- (void)dealloc
{
    NSLog(@"----%@ dealloc", self);
}

@end
