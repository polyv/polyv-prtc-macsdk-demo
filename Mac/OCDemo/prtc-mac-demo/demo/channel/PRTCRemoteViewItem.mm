//
//  PRTCRemoteViewItem.m
//  PRTC
//
//  Created by PRTC on 2020/10/12.
//  Copyright © 2020 PRTC. All rights reserved.
//

#import "PRTCRemoteViewItem.h"
#import <PRTCSDK_Mac/PRTCTypeDef.h>

#import "PRTCStream.h"
#import "PRTCEngineObjc.h"

@interface PRTCRemoteViewItem ()
@property (strong) NSView *renderView;
@property (weak) IBOutlet NSButton *muteCamBtn;

@end

@implementation PRTCRemoteViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
}





- (void)setStreamModel:(PRTCStream *)streamModel {
    _streamModel = streamModel;
        
    [_renderView removeFromSuperview];
    
    _renderView = [NSView new];
    _renderView.frame = self.view.bounds;
    [self.view addSubview:_renderView positioned:(NSWindowBelow) relativeTo:self.muteCamBtn];
//    [self.view addSubview:_renderView];
    
    _streamModel.remoteView = _renderView;

    [streamModel startRemoteView];
        
}

- (IBAction)camaroClick:(NSButton *)sender {
    if (self.muteComplete) {
        self.muteComplete(self.streamModel, 0, sender.state);
    }
}

- (IBAction)micClick:(NSButton *)sender {
    if (self.muteComplete) {
        self.muteComplete(self.streamModel, 1, sender.state);
    }
}

- (void)dealloc {
    NSLog(@"------%@ dealloc-----",self);
    
}
@end
