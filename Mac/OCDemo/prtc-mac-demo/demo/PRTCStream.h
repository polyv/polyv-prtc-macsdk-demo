//
//  PRTCStream.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/8.
//

#import <Cocoa/Cocoa.h>
#import <PRTCSDK_Mac/PRTCTypeDef.h>

NS_ASSUME_NONNULL_BEGIN

@interface PRTCStream : NSObject
@property (nonatomic, copy) NSString *mUserId;
@property (nonatomic, copy) NSString *mStreamId;
@property (nonatomic, assign) BOOL mEnableVideo;
@property (nonatomic, assign) BOOL mEnableAudio;
@property (nonatomic, assign) BOOL mEnableData;
@property (nonatomic, assign) BOOL mMuteVideo;
@property (nonatomic, assign) BOOL mMuteAudio;

@property (nonatomic, strong) NSView *remoteView;

@property (nonatomic, assign) ePRTCMeidaType mStreamMtype;

@property (nonatomic, assign) tPRTCVideoCanvas remoteCanvas;


- (void)startRemoteView;

- (void)stopRemoteView;


@end

NS_ASSUME_NONNULL_END
