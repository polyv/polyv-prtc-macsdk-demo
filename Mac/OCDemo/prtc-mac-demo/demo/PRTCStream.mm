//
//  PRTCStream.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/8.
//

#import "PRTCStream.h"
#import "PRTCEngineObjc.h"

@implementation PRTCStream



- (tPRTCVideoCanvas)remoteCanvas {
    tPRTCVideoCanvas canvas;
    canvas.mVideoView = (__bridge void*)_remoteView;
    canvas.mUserId = [_mUserId UTF8String];
    canvas.mStreamId = [_mStreamId UTF8String];
    canvas.mStreamMtype = PRTC_MEDIATYPE_VIDEO;
    canvas.mRenderMode = PRTC_RENDER_MODE_FIT;
    canvas.mVideoFrameType = PRTC_VIDEO_FRAME_TYPE_I420;
    
    return canvas;
    
    
}



- (void)startRemoteView {
    
    tPRTCVideoCanvas canvas = self.remoteCanvas;
    
    [[PRTCEngineObjc shared] startRemoteView:canvas];
}


- (void)stopRemoteView {
    tPRTCVideoCanvas canvas = _remoteCanvas;

    [[PRTCEngineObjc shared] stopRemoteView:canvas];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.remoteView removeFromSuperview];
    });

}

@end
