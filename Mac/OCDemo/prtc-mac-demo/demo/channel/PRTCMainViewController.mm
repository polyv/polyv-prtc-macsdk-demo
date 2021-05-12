//
//  PRTCMainViewController.m
//  URTC
//
//  Created by PRTC on 2020/10/12.
//  Copyright © 2020 PRTC. All rights reserved.
//

#import "PRTCMainViewController.h"
#import "AppDelegate.h"
#import "PRTCLoginWindowViewController.h"

#import "PRTCRemoteViewItem.h"
#import "PRTCStream.h"
//测试
#define APP_ID @"URtc-h4r1txxy"
#define APP_KEY @"9129304dbf8c5c4bf68d70824462409f"

#import "PRTCEngineObjc.h"
#import "PRTCTokenManager.h"
#import <PRTCSDK_Mac/PRTCTypeDef.h>

class PRTCVideoFrameObserver : public IPRTCVideoFrameObserver {

public:
    PRTCVideoFrameObserver(const char *filename):
        _video_file(nullptr),_video_buf(nullptr)
    {
        _video_file = fopen(filename, "rb");
        fseek(_video_file, 0, SEEK_END);
        auto fileSize = ftell(_video_file);
        fseek(_video_file, 0, SEEK_SET);
        fileSize = fileSize;
        const uint32_t read_video_size = 1280 * 720 * 3 / 2;
        
        _video_buf = new uint8_t[read_video_size];
        
    };
    virtual ~PRTCVideoFrameObserver(){
        if(_video_file)
        {
            fclose(_video_file);
            _video_file = nullptr;
        }
        if(_video_buf) delete [] _video_buf; _video_buf = nullptr;
    };
    
    bool onCaptureFrame(tPRTCVideoFrame *videoFrame) override
    {
        if (!_video_file || !_video_buf) {
            return false;
        }
        uint32_t read_video_size = 1280 * 720 * 3 / 2;
        auto size = fread(_video_buf, 1, read_video_size, _video_file);
        if (size != read_video_size) {
            fseek(_video_file, 0, SEEK_SET);
            fread(_video_buf, 1, read_video_size, _video_file);
        }
        memcpy(videoFrame->mDataBuf, _video_buf, read_video_size);
        videoFrame->mHeight = 720;
        videoFrame->mWidth = 1280;
        videoFrame->mVideoType = PRTC_VIDEO_FRAME_TYPE_I420;
        videoFrame->renderTimeMs = 0;
        return true;
    };
    
    FILE *_video_file;
    uint8_t *_video_buf;
};
class  UrtcIAudioFrameObserver : public IPRTCAudioFrameObserver {

public:
    UrtcIAudioFrameObserver(const char *filename){
        _audio_file = fopen(filename, "rb");
        uint32_t deliver_sample_size = 480;

        uint32_t read_audio_size = deliver_sample_size * 2 * 2;

        _audio_buf = new uint8_t[read_audio_size];
    };
    virtual ~UrtcIAudioFrameObserver(){
        fclose(_audio_file);
        delete [] _audio_buf;
    };
    virtual  bool onCaptureFrame(tPRTCAudioFrame* audioFrame) {
        if (!_audio_file) {
            return false;
        }
        uint32_t deliver_sample_size = 480;
        uint32_t read_audio_size = deliver_sample_size * 2 * 2;
    
        auto read_size = fread(_audio_buf, 1, read_audio_size, _audio_file);

        if (read_size != read_audio_size) {
            fseek(_audio_file, 0, SEEK_SET);
            fread(_audio_buf, 1, read_audio_size, _audio_file);
        }
        
        memcpy(audioFrame->mAudioData, _audio_buf, read_audio_size);
        audioFrame->mChannels = 2;
        audioFrame->mNumSimples = deliver_sample_size;
        audioFrame->mBytePerSimple = 4;
        audioFrame->mSimpleRate = 48000;
        audioFrame->renderTimeMs = 0;
            
        return true;
    };
    
    FILE *_audio_file;
    uint8_t *_audio_buf;
};


class  URtcExtendVideoCaptureSource: public IPRTCExtendVideoCaptureSource
{
public:
    URtcExtendVideoCaptureSource();
    virtual ~URtcExtendVideoCaptureSource();
    virtual  bool doCaptureVideoFrame(tPRTCVideoFrame* videoframe) = 0;
};



@interface PRTCMainViewController ()<NSCollectionViewDelegate, NSCollectionViewDataSource,PRTCEngineObjcDelegate>
{
    PRTCEngineObjc * _prtcEngineObjc;
    tPRTCVideoCanvas _localCanvas;
    
    
    BOOL _isPush; // 是否在转推
    BOOL _isRecord;// 是否在录制
    
    dispatch_queue_t _audioQueue;
}
@property (strong) NSView *localView;
@property (weak) IBOutlet NSCollectionView *collectionView;
@property (weak) IBOutlet NSButton *stopBtn;
@property (weak) IBOutlet NSButton *micBtn;
@property (weak) IBOutlet NSButton *camaroBtn;
@property (strong) IBOutlet NSView *topBarView;
@property (weak) IBOutlet NSTextField *roomLB;
@property (weak) IBOutlet NSTextField *userLB;
@property (weak) IBOutlet NSTextField *timeField;

@property (strong) IBOutlet NSView *localScreenView;
@property (weak) IBOutlet NSButton *publishCamaroBtn;
@property (weak) IBOutlet NSButton *desktopBtn;
@property (weak) IBOutlet NSButton *pushBtn;
@property (weak) IBOutlet NSButton *recordBtn;


@property (weak) IBOutlet NSButton *extendVideoBtn;
@property (nonatomic, strong) dispatch_source_t timer;


@property (nonatomic, strong) NSMutableArray *canSubstreamList;
@property (nonatomic, strong) NSMutableArray *remoteStreamList;//已订阅远端流
@property (nonatomic, strong) NSMutableArray *collectionViewRenderList;//collectionview渲染列表

@property (nonatomic, assign) BOOL stop_push_thread;

@end
static NSString *mainCellID = @"PRTCRemoteViewItemId";

@implementation PRTCMainViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"-----%@ dealloc-------", self);
    
//    [PRTCEngineObjc destroy];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    _canSubstreamList = [NSMutableArray arrayWithCapacity:0];
    _remoteStreamList = [NSMutableArray arrayWithCapacity:0];
    _collectionViewRenderList = [NSMutableArray arrayWithCapacity:0];
          
    [self setupUI];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willClose:) name:NSWindowWillCloseNotification object:nil];
}

- (void)setRoomId:(NSString *)roomId {
    _roomId = roomId;
    self.roomLB.stringValue = self.roomId;
}
- (void)setUserId:(NSString *)userId {
    _userId = userId;
    self.userLB.stringValue = self.userId;
}

- (void)setConfig:(PRTCConfigModel *)config {
    _config = config;
    self.publishCamaroBtn.hidden = _config.autoPublish;
    self.desktopBtn.hidden = _config.autoPublishScreen;
    // 初始化SDK
    [self initUrtcEngine];
}

-(void)willClose:(NSNotification*)notification{
    NSWindow *window = notification.object;
    if (self.view.window == window) {
        [self leaveRoomAction];
    }
}
- (void)viewDidAppear {
    [super viewDidAppear];

    [self setupTrackArea];

}

- (void)viewDidDisappear {
    [super viewDidDisappear];
    
//    [PRTCEngineObjc destroy];
}

- (void)viewDidLayout {
    [super viewDidLayout];

    [self updateTrackingAreas];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

#pragma mark--初始化SDK
- (void)initUrtcEngine {
    
    tPRTCInitContext *ctx = new tPRTCInitContext;
    ctx->mIsInline = true;
    ctx->mLogLevel = PRTC_LOG_LEVEL_DEBUG;
    ctx->mMaxReconnect = 999;
    ctx->mIsMediaCodec = false;
    ctx->mMediaCodec = PRTC_INTEL_MEDIACODEC;
    ctx->mLogPath =  "/Users/PRTC/Downloads/";
    ctx->mLogName = "urtc_log.txt";
    
//    PRTCEngineObjc *prtcEngineObjc1 = [PRTCEngineObjc shared];

    PRTCEngineObjc *prtcEngineObjc = [PRTCEngineObjc sharedWithContext:ctx];
    
    
    _prtcEngineObjc = prtcEngineObjc;
    prtcEngineObjc.delegate = self;
    [prtcEngineObjc setSdkMode:PRTC_SDK_MODE_NORMAL];
//    _config.channelType == 0 ? PRTC_CHANNEL_TYPE_COMMUNICATION : PRTC_CHANNEL_TYPE_BROADCAST
    
    [prtcEngineObjc setChannelType: _config.channelType == 0 ? PRTC_CHANNEL_TYPE_COMMUNICATION : PRTC_CHANNEL_TYPE_BROADCAST];
    
    
    ePRTCUserStreamRole streamRole = PRTC_USER_STREAM_ROLE_BOTH;
    if (_config.rolePublish) {
        streamRole = PRTC_USER_STREAM_ROLE_PUB;
    }
    if (_config.roleSubscribe) {
        streamRole = PRTC_USER_STREAM_ROLE_SUB;
    }
    if (_config.rolePublish && _config.roleSubscribe) {
        streamRole = PRTC_USER_STREAM_ROLE_BOTH;
    }
    [prtcEngineObjc setVideoCodec:(PRTC_CODEC_H264)];
    [prtcEngineObjc setStreamRole:streamRole];
    [prtcEngineObjc setLogLevel:PRTC_LOG_LEVEL_DEBUG];
//    [prtcEngineObjc setLogLevel:PRTC_LOG_LEVEL_INFO];
    [prtcEngineObjc setTokenSecKey:APP_KEY];
    
    [prtcEngineObjc setVideoCodec:_config.videoCodec == 1 ? PRTC_CODEC_VP8 : PRTC_CODEC_H264];
    
//    (ePRTCVideoProfile)_config.videoProfle
    [prtcEngineObjc setVideoCaptureProfile:(ePRTCVideoProfile)_config.videoProfle];
    tPRTCVideoConfig videoconfig;
    [prtcEngineObjc setVideoProfile:(ePRTCVideoProfile)_config.videoProfle config:videoconfig];
    
     
    [prtcEngineObjc setAutoPublish:_config.autoPublish subscribe:_config.autoSubscribe];
//    [prtcEngineObjc setAutoPublish:false subscribe:_config.autoSubscribe];

    
    [prtcEngineObjc configLocalScreenPublish:_config.autoPublishScreen];
    [prtcEngineObjc configLocalCameraPublish:_config.autoPublishVideo];
//    [prtcEngineObjc configLocalCameraPublish:false];

   
    [prtcEngineObjc setAudioOnlyMode:_config.isOnlyAudio];
    
   
// 开启外部音频源
//    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"likeu.wav" ofType:nil];
//    UrtcIAudioFrameObserver *audioFrameObserver = new UrtcIAudioFrameObserver([filepath UTF8String]);
//    [_prtcEngineObjc registerAudioFrameObserver:audioFrameObserver];
//    [_prtcEngineObjc enableExtendAudiocapture:true source:nil];
    


    NSString *token = [PRTCTokenManager getTokenWithAppId:APP_ID userID:_userId roomID:_roomId andAppSecret:APP_KEY];
    
    tPRTCAuth auth;
    auth.mAppId = [APP_ID UTF8String];
    auth.mRoomId = [_roomId UTF8String];
    auth.mUserId = [_userId UTF8String];
    auth.mUserToken = [token UTF8String];
   
    // 加入房间
    [prtcEngineObjc joinChannel:auth];

    // 渲染本地流
    _localView = [NSView new];
    _localView.frame = self.view.bounds;
    [self.view addSubview:_localView positioned:(NSWindowBelow) relativeTo:self.topBarView];

    _localView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:_localView attribute:NSLayoutAttributeTop relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_localView attribute:NSLayoutAttributeTrailing relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_localView attribute:NSLayoutAttributeBottom relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:_localView attribute:NSLayoutAttributeLeading relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0],
    ]];
    
    
    tPRTCVideoCanvas localCanvas;
    localCanvas.mVideoView = (__bridge void*)self.localView;
    localCanvas.mUserId = [_userId UTF8String];
    localCanvas.mStreamMtype = PRTC_MEDIATYPE_VIDEO;
    localCanvas.mRenderMode = PRTC_RENDER_MODE_DEFAULT;
    localCanvas.mVideoFrameType = PRTC_VIDEO_FRAME_TYPE_I420;
    [prtcEngineObjc startPreview:localCanvas];
    
    
    NSLog(@"version :%@", [prtcEngineObjc getSdkVersion]);
 
    
}

- (IBAction)leaveRoom:(NSButton *)sender {
        
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleWarning;
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    alert.messageText = @"提示";
    alert.informativeText = @"你确定要离开房间吗？";
    __weak typeof(self) weakSelf = self;
    [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            
            [weakSelf leaveRoomAction];
            
        } else if (returnCode == NSAlertSecondButtonReturn) {
            NSLog(@"取消");
        } else {
            NSLog(@"else");
        }
    }];
      
}

#pragma mark -- 离开房间
- (void)leaveRoomAction {
    // 离开房间
    [_prtcEngineObjc stopPreview:self->_localCanvas];
    
    [self.localView removeFromSuperview];

    for (PRTCStream *stream in _remoteStreamList) {
        [stream stopRemoteView];
    }
    [_remoteStreamList removeAllObjects];
    [self.collectionView reloadData];

    if (_isPush) {
        [self stopPush];
    }
    if (_isRecord) {
        [_prtcEngineObjc stopRecord];
    }
    [_prtcEngineObjc leaveChannel];
//    [PRTCEngineObjc destroy];
    
    // 销毁定时器
    [self removeTimer];
    
    
    PRTCLoginWindowViewController *loginWindowController = [PRTCLoginWindowViewController windowController];
    AppDelegate *appDelegate = (AppDelegate *)[NSApplication sharedApplication].delegate;
    appDelegate.mainWindowController = loginWindowController;
    
    [loginWindowController.window makeKeyAndOrderFront:self];
    [self.view.window orderOut:self];
    
}

- (IBAction)openMicrophone:(NSButton *)sender {
    if ([_prtcEngineObjc isLocalAudioPublishEnabled]) {
        [_prtcEngineObjc muteLocalMic:sender.state streamType:(PRTC_MEDIATYPE_VIDEO)];
    }
    
}

- (IBAction)openCamaro:(NSButton *)sender {
    if ([_prtcEngineObjc isLocalCameraPublishEnabled]) {
        [_prtcEngineObjc muteLocalVideo:sender.state streamtype:PRTC_MEDIATYPE_VIDEO];
    }
}
- (IBAction)audioMix:(NSButton *)sender {
    if (sender.state == NSControlStateValueOn) {
        NSOpenPanel *filePanel = [[NSOpenPanel alloc] init];
        
        filePanel.canChooseFiles = true;
        filePanel.canChooseDirectories = false;
        filePanel.allowsMultipleSelection = false;
        filePanel.allowedFileTypes = @[@"wav"];
        [filePanel beginWithCompletionHandler:^(NSModalResponse result) {
            if (result == NSModalResponseOK) {
                NSURL *url = filePanel.URLs.firstObject;
                NSString *urlStr = url.absoluteString;
    //            @"/Users/PRTC/Downloads/likeu.wav"
                int ret = [self->_prtcEngineObjc startAudioMixing:urlStr replaceAudio:false loop:true musicvol:0.2];
                NSLog(@"--------startAudioMixing:%d",ret);
                
            }
            
        }];
    } else {
        [_prtcEngineObjc stopAudioMixing];
    }
    
    
  
}

/// 发布摄像头
- (IBAction)publishVideo:(NSButton *)sender {
    

    if (sender.state == NSControlStateValueOn) {
       
        [_prtcEngineObjc publish:(PRTC_MEDIATYPE_VIDEO) hasvideo:_config.autoPublishVideo hasaudio:_config.autoPublishAudio];

    } else {

        [_prtcEngineObjc unPublish:PRTC_MEDIATYPE_VIDEO];

    }
    
}
/// 云端录制
- (IBAction)cloudRecord:(NSButton *)sender {
    if (sender.state == NSControlStateValueOn) {
        
        tPRTCRecordConfig recordConfig;
        recordConfig.mMainviewuid = [_userId UTF8String];
        recordConfig.mBucket = "urtc-test";
        recordConfig.mBucketRegion = "cn-bj";
        recordConfig.mProfile = PRTC_RECORDPROFILE_SD;
        recordConfig.mWatermarkPos = PRTC_WATERMARKPOS_LEFTTOP;
        recordConfig.mMainviewmediatype = PRTC_MEDIATYPE_VIDEO;
        recordConfig.mWaterMarkType = PRTC_WATERMARK_TYPE_TIME;
        recordConfig.mLayout = 1;
        recordConfig.mWatermarkUrl = "";
        recordConfig.mIsaverage = false;
        recordConfig.mMixerTemplateType = PRTC_WATERMARK_TYPE_TIME;
        

        [_prtcEngineObjc startRecord:recordConfig];

    } else {
        int ret = [_prtcEngineObjc stopRecord];
        if (ret < 0) {
            NSLog(@"-----停止录制失败---");
        }

    }
    
//http://urtc-test.cn-bj.ufileos.com/r6661_URtc-h4r1txxy_rtc1615890915.mp4
}

/// 旁路推流
- (IBAction)cloudPush:(NSButton *)sender {
    if (sender.state == NSControlStateValueOn) {
        

        NSString *pushUrl = [NSString stringWithFormat:@"rtmp://rtcpush.ugslb.com/rtclive/%@",_roomId];
    //http://rtchls.ugslb.com/rtclive/xxx.flv, xxx是roomid
        tPRTCTranscodeConfig *config = new tPRTCTranscodeConfig();
        tPRTCBackgroundColor mbgColor;
        mbgColor.mRed = 100;
        mbgColor.mGreen = 200;
        mbgColor.mBlue = 100;
        
        config->mbgColor = mbgColor;
        config->mFramerate = 15;
        config->mBitrate = 600;
    //    config->mKeyUid = [_userId UTF8String];
        config->mMainViewUid = [_userId UTF8String];
        config->mMainviewType = 1;
        config->mWidth = 640;
        config->mHeight = 480;
        
        config->mStyle = "URTC";
        
        config->mWatermarkPos = PRTC_WATERMARKPOS_LEFTTOP;
        config->mWaterMarkType = PRTC_WATERMARK_TYPE_PIC;
        config->mWatermarkUrl= "http://urtc-living-test.cn-bj.ufileos.com/test.png";
        
        
        [_prtcEngineObjc addPublishStreamUrl:pushUrl config:config];
        
    } else {
        [self stopPush];
    }
}

- (void)stopPush {
    NSString *pushUrl = [NSString stringWithFormat:@"rtmp://rtcpush.ugslb.com/rtclive/%@.flv",_roomId];
    [_prtcEngineObjc removePublishStreamUrl:pushUrl];
}

/// 发布桌面
- (IBAction)shareDesktop:(NSButton *)sender {
    
    if (sender.state == NSControlStateValueOn) {
        
        [_prtcEngineObjc publish:(PRTC_MEDIATYPE_SCREEN) hasvideo:YES hasaudio:false];
        
    } else {

        [_prtcEngineObjc unPublish:PRTC_MEDIATYPE_SCREEN];
    }
    
}


- (IBAction)doCaptureExtendVideo:(NSButton *)sender {
    if (sender.state == NSControlStateValueOn) {
        // 替换视频源
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"video_1280x720.yuv" ofType:nil];
        PRTCVideoFrameObserver *videoFrameObserver = new PRTCVideoFrameObserver([filepath UTF8String]);
        [_prtcEngineObjc registerVideoFrameObserver:videoFrameObserver];
        [_prtcEngineObjc enableExtendVideocapture:true source:nil];
    } else {
        [_prtcEngineObjc registerVideoFrameObserver:nil];
        [_prtcEngineObjc enableExtendVideocapture:false source:nil];

    }
   
    
    
}





#pragma mark -- NSCollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_remoteStreamList count];
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    
    PRTCRemoteViewItem *item = [collectionView makeItemWithIdentifier:mainCellID forIndexPath:indexPath];
    item.streamModel = _remoteStreamList[indexPath.item];
    
    item.muteComplete = ^(PRTCStream * _Nonnull stream, int type, BOOL mute) {
        tPRTCMuteSt muteSt ;
        muteSt.mUserId = [stream.mUserId UTF8String];
        muteSt.mStreamId = [stream.mStreamId UTF8String];
        muteSt.mMute = mute;
        muteSt.mStreamMtype = stream.mStreamMtype;
        
        switch (type) {
            case 0:
             
                [self->_prtcEngineObjc muteRemoteVideo:muteSt mute:mute];
                break;
             case 1:
                [self->_prtcEngineObjc muteRemoteAudio:muteSt mute:mute];

                break;
            default:
                break;
        }
    };

    return item;
}






#pragma mark ---引擎代理
- (void)onServerDisconnect{
    NSLog(@"delegate:-----onServerDisconnect");
    
}
///加入房间回调
///@param code 错误码  0成功
///@param msg 错误信息
///@param uid 用户id
///@param roomid 房间id
- (void)onJoinRoom:(int)code msg:(NSString*)msg uid:(NSString*)uid roomid:(NSString*) roomid{
    NSLog(@"delegate:-----onJoinRoom");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupTimer];
    });
    
}

///离开房间回调
///@param code 错误码  0成功
///@param msg 错误信息
///@param uid 用户id
///@param roomid 房间id
- (void)onLeaveRoom:(int)code msg:(NSString*)msg uid:(NSString*)uid roomid:(NSString*) roomid{
    NSLog(@"delegate:-----onLeaveRoom");
}

///断线重连回调
///@param uid 用户id
///@param roomid 房间id
- (void)onRejoining:(NSString*)uid roomid:(NSString*) roomid{
    NSLog(@"delegate:-----onRejoining");
}

///重新加入房间成功回调
///@param uid 用户id
///@param roomid 房间id
- (void)onReJoinRoom:(NSString*)uid roomid:(NSString*) roomid{
    NSLog(@"delegate:-----onReJoinRoom");
}

///本地流发布回调
///@param code 错误码  0 succ
///@param msg 本地发布错误信息
///@param info 发布成功后本地流信息
- (void)onLocalPublish:(int)code msg:(NSString*)msg info:(tPRTCStreamInfo&)info{
    NSLog(@"delegate:-----onLocalPublish");

    if (info.mStreamMtype == PRTC_MEDIATYPE_SCREEN) {
        tPRTCVideoCanvas localScreenCanvas;
        localScreenCanvas.mVideoView = (__bridge void*)self.localScreenView;
        localScreenCanvas.mUserId = [_userId UTF8String];
        localScreenCanvas.mStreamMtype = PRTC_MEDIATYPE_SCREEN;
        localScreenCanvas.mRenderMode = PRTC_RENDER_MODE_DEFAULT;
        localScreenCanvas.mVideoFrameType = PRTC_VIDEO_FRAME_TYPE_I420;
        [_prtcEngineObjc startPreview:localScreenCanvas];
    }
    
    
}

///本地流取消发布回调
///@param code 错误码  0 succ
///@param msg 本地发布错误信息
///@param info 取消发布成功后本地流信息
- (void)onLocalUnPublish:(int)code msg:(NSString*)msg info:(tPRTCStreamInfo&)info{
    NSLog(@"delegate:-----onLocalUnPublish");
}

///远端用户加入回调
///@param uid 远端用户id
- (void)onRemoteUserJoin:(NSString*)uid{
    NSLog(@"delegate:-----onRemoteUserJoin");
}

///远端用户离开回调
///@param uid 远端用户id
///@param reason 离开原因
- (void)onRemoteUserLeave:(NSString*)uid reason:(int)reason{
    NSLog(@"delegate:-----onRemoteUserLeave");
}

///远端流发布回调
///@param info 远端流信息
- (void)onRemotePublish:(tPRTCStreamInfo&)info{
    NSLog(@"delegate:-----onRemotePublish");
    
}

///远端流取消发布回调
///@param info 远端流信息
- (void)onRemoteUnPublish:(tPRTCStreamInfo&)info{
    NSLog(@"delegate:-----onRemoteUnPublish");
    NSString *userId = [NSString stringWithUTF8String:info.mUserId];
    ePRTCMeidaType mediaType = info.mStreamMtype;
    PRTCStream *delStream;
    for (PRTCStream *stream in _remoteStreamList) {
        if ([stream.mUserId isEqual:userId] && stream.mStreamMtype == mediaType) {
            delStream = stream;
        }
    }
    
    if (delStream) {
        [delStream stopRemoteView];
        [_remoteStreamList removeObject:delStream];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
    
    

}

///订阅回调
///@param code 订阅结果 0 succ
///@param msg 订阅提示信息
///@param info 订阅流信息
- (void)onSubscribeResult:(int)code msg:(NSString *)msg info:(tPRTCStreamInfo&)info{
    NSLog(@"delegate:-----onSubscribeResult");
    
    PRTCStream *stream = [self createStreamWithInfo:info];
    
    if (stream) {
        [_remoteStreamList addObject:stream];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }

}

///取消订阅回调
///@param code 取消订阅结果 0 succ
///@param msg 订阅提示信息
///@param info 订阅流信息
- (void)onUnSubscribeResult:(int)code msg:(NSString*)msg info:(tPRTCStreamInfo&)info{
    NSLog(@"delegate:-----onUnSubscribeResult");
}

///本地mute回调
///@param code mute回调结果 0 succ
///@param msg  提示信息
///@param mediatype 媒体类型
///@param tracktype track类型
///@param mute mute状态
- (void)onLocalStreamMuteRsp:(int)code msg:(NSString*)msg mediatype:(ePRTCMeidaType)mediatype tracktype:(ePRTCTrackType)tracktype mute:(bool)mute {
    NSLog(@"delegate:-----onLocalStreamMuteRsp");
}

///远端mute回调
///@param code mute回调结果 0 succ
///@param msg  提示信息
///@param uid  远端用户id
///@param mediatype 媒体类型
///@param tracktype track类型
///@param mute mute状态
- (void)onRemoteStreamMuteRsp:(int)code msg:(NSString*)msg uid:(NSString*)uid mediatype:(ePRTCMeidaType)mediatype tracktype:(ePRTCTrackType)tracktype mute:(bool)mute{
    NSLog(@"delegate:-----onRemoteStreamMuteRsp");
}

///远端音频轨或者视频轨状态回调
///@param uid  远端用户id
///@param mediatype 媒体类型
///@param tracktype track类型
///@param mute mute状态
- (void)onRemoteTrackNotify:(NSString*)uid mediatype:(ePRTCMeidaType)mediatype tracktype:(ePRTCTrackType)tracktype mute:(bool)mute{
    NSLog(@"delegate:-----onRemoteTrackNotify");
}

///开启录制回调
///@param code  0 succ
///@param msg 错误提示信息
///@param info 录制信息
- (void)onStartRecord:(int)code msg:(NSString*)msg info:(tPRTCRecordInfo&)info{
    NSLog(@"delegate:-----onStartRecord: code:%d ; msg:%@", code, msg);
    if (code == 0) {
        _isRecord = YES;
        NSString *mBucket = [NSString stringWithUTF8String:info.mBucket];
        NSString *mRegion = [NSString stringWithUTF8String:info.mRegion];
        NSString *mFileName = [NSString stringWithUTF8String:info.mFileName];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAlert *alert = [[NSAlert alloc] init];
            alert.alertStyle = NSAlertStyleWarning;
            [alert addButtonWithTitle:@"复制地址"];
            [alert addButtonWithTitle:@"取消"];
            alert.messageText = @"录制结束后，复制地址查看";
            
            NSString *fileurl = [NSString stringWithFormat:@"http://%@.%@.ufileos.com/%@.mp4", mBucket, mRegion, mFileName];
            
        //         http://"bucket存储空间名称.region地域.ufileos.com"/"file_name".mp4
            alert.informativeText = fileurl;
        //        __weak typeof(self) weakSelf = self;
            [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:^(NSModalResponse returnCode) {
                if (returnCode == NSAlertFirstButtonReturn) {
        //                 http://"bucket存储空间名称.region地域.ufileos.com"/"file_name".mp4
                    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
                    [pasteboard declareTypes:@[NSPasteboardTypeString] owner:nil];
                    [pasteboard setString:fileurl forType:NSPasteboardTypeString];
        //
                    
                } else if (returnCode == NSAlertSecondButtonReturn) {
                    NSLog(@"取消");
                } else {
                    NSLog(@"else");
                }
            }];
        });
        
    }
    
}

///停止录制回调
///@param code  0 succ 0代表主动停止成功 非0代表异常停止需要重新开启
///@param msg 错误提示信息
///@param recordid 录制ID
- (void)onStopRecord:(int)code msg:(NSString *)msg recordid:(NSString*)recordid{
    NSLog(@"delegate:-----onStopRecord");
    if (code == 0) {
        _isRecord = NO;
    }
}

///本地数据统计回调
///@param rtstats 统计信息
- (void)onSendRTCStats:(tPRTCStreamStats&)rtstats{
    NSLog(@"delegate:-----onSendRTCStats");
}

///远端数据统计回调
///@param rtstats 统计信息
- (void)onRemoteRTCStats:(tPRTCStreamStats)rtstats{
    NSLog(@"delegate:-----onRemoteRTCStats");
}

///远端音频能量回调
///@param uid 用户ID
///@param volume 音量大小
- (void)onRemoteAudioLevel:(NSString*)uid volume:(int)volume{
    NSLog(@"delegate:-----onRemoteAudioLevel");
}

///网络评分回调
///@param uid 用户ID
///@param rtype 网络上下型类型
///@param Quality 评分
- (void)onNetworkQuality:(NSString*)uid quality:(ePRTCNetworkQuality&)rtype qualityType:(ePRTCQualityType&)Quality{
    NSLog(@"delegate:-----onNetworkQuality");
}

///旁推状态回调
///@param state rtmp状态
///@param url cdn地址
///@param code 错误码
- (void)onRtmpStreamingStateChanged:(int)state url:(NSString*)url code:(int)code{
    NSLog(@"delegate:-----onRtmpStreamingStateChanged: state:%d; url∫:%@, code:%d", state, url, code);
//http://rtchls.ugslb.com/rtclive/r666.flv
    if (code == 0 && state == PRTC_RTMP_STREAM_PUBLISH_STATE_RUNNING) {
        _isPush = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAlert *alert = [[NSAlert alloc] init];
            alert.alertStyle = NSAlertStyleWarning;
            [alert addButtonWithTitle:@"复制地址"];
            [alert addButtonWithTitle:@"取消"];
            alert.messageText = @"播放地址";
            NSString *pushUrl = [NSString stringWithFormat:@"http://rtchls.ugslb.com/rtclive/%@.flv", _roomId];
            alert.informativeText = pushUrl;
            [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:^(NSModalResponse returnCode) {
                if (returnCode == NSAlertFirstButtonReturn) {
                    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
                    [pasteboard declareTypes:@[NSPasteboardTypeString] owner:nil];
                    [pasteboard setString:pushUrl forType:NSPasteboardTypeString];
                    
                } else if (returnCode == NSAlertSecondButtonReturn) {
                    NSLog(@"取消");
                } else {
                    NSLog(@"else");
                }
            }];
        });
        
    } else {
        _isPush = NO;
    }
    
    
}

///旁推更新混合流回调
///@param cmd 操作类型
///@param code 错误码
///@param msg 错误信息
- (void)onRtmpUpdateMixStreamRes:(ePRTCRtmpOpration&)cmd code:(int)code msg:(NSString*) msg{
    NSLog(@"delegate:-----onRtmpUpdateMixStreamRes");
}

///设备报错回调
///@param code 设备报错回调
- (void)onCaptureError:(int)code detail:(int)detail{
    NSLog(@"delegate:-----onCaptureError");
}

///本地音频能量回调
///@param volume 音量大小
- (void)onLocalAudioLevel:(int)volume{
    NSLog(@"delegate:-----onLocalAudioLevel");
}


///远端音频播放首帧回调
///@param uid 用户id
///@param elapsed 从加入房间到收到远端音频距离的时间
- (void)onFirstRemoteAudioFrame:(NSString*)uid elapsed:(int)elapsed{
    NSLog(@"delegate:-----onFirstRemoteAudioFrame");
}


///远端视频首帧回调
///@param uid 用户id
///@param width 宽度
///@param height 高度
///@param elapsed 从加入房间到收到远端视频渲染距离的时间
- (void)onFirstRemoteVideoFrame:(NSString*)uid width:(int)width height:(int)height elapsed:(int)elapsed{
    NSLog(@"delegate:-----onFirstRemoteVideoFrame");
}

///自定义消息接口发送结果
/// @param code 错误
/// @param msg 详细信息
- (void)onSendMsgRsp:(int)code msg:(NSString*)msg{
    NSLog(@"delegate:-----onSendMsgRsp");
}

///广播消息通知
///@param uid 用户id
///@param msg 用户消息
- (void)onBroadMsgNotify:(NSString*)uid msg:(NSString *)msg{
    NSLog(@"delegate:-----onBroadMsgNotify");
}

///踢人通知
///@param code 错误码
- (void)onKickoff:(int)code{
    NSLog(@"delegate:-----onKickoff");
}

///警告回调
///@param warn 错误码
- (void)onWarning:(int)warn{
    NSLog(@"delegate:-----onWarning");
}

///错误回调
///@param error 错误码
- (void)onError:(int)error{
    NSLog(@"delegate:-----onError");
}


#pragma mark UI设置
- (void)setupUI {
    
    [self setupCollectionView];
    
    self.topBarView.wantsLayer = YES;
    self.topBarView.layer.backgroundColor = [NSColor colorWithWhite:1 alpha:0.35].CGColor;
    
    NSColor *white = [NSColor whiteColor];

    [self setBtnTitleColorwithColor:white andBtn:self.publishCamaroBtn];
    [self setBtnTitleColorwithColor:white andBtn:self.desktopBtn];
    [self setBtnTitleColorwithColor:white andBtn:self.pushBtn];
    [self setBtnTitleColorwithColor:white andBtn:self.recordBtn];
    [self setBtnTitleColorwithColor:white andBtn:self.extendVideoBtn];


    
}
-(void)setBtnTitleColorwithColor:(NSColor*)color andBtn:(NSButton*)btn{

    NSString *title = btn.title;
    
    NSString *alternateTitle = btn.alternateTitle;
    
    NSMutableParagraphStyle *defaultStyle = [[NSMutableParagraphStyle alloc] init];
    defaultStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dicAtt = @{NSForegroundColorAttributeName: [NSColor whiteColor], NSParagraphStyleAttributeName: defaultStyle};

    
    btn.title = @" ";
    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithAttributedString:btn.attributedTitle];
    // 替换文字
    [attTitle replaceCharactersInRange:NSMakeRange(0, 1) withString:title];
    // 添加属性
    [attTitle addAttributes:dicAtt range:NSMakeRange(0, title.length)];
    btn.attributedTitle = attTitle;
    
    
    dicAtt = @{NSForegroundColorAttributeName:[NSColor colorWithRed:190/255.0 green:0 blue:10/255.0 alpha:1], NSParagraphStyleAttributeName: defaultStyle};
    btn.alternateTitle = @" ";
    attTitle = [[NSMutableAttributedString alloc] initWithAttributedString:btn.attributedAlternateTitle];
    // 替换文字
    [attTitle replaceCharactersInRange:NSMakeRange(0, 1) withString:alternateTitle];
    // 添加属性
    [attTitle addAttributes:dicAtt range:NSMakeRange(0, alternateTitle.length)];
    btn.attributedAlternateTitle = attTitle;
    
}


- (void)setupTimer {
    __block int count = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        count ++;
        int seconds = count % 60;
        int minutes = (count / 60) % 60;
        int hours = count / 3600;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeField.stringValue = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
        });
        
       
    });
    dispatch_resume(_timer);
}

- (void)removeTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}



- (void)mouseEntered:(NSEvent *)event {
    NSDictionary *userInfo = event.trackingArea.userInfo;
    [self updateTrackingAreaWithUserInfo:userInfo eventType:1];
        
}

- (void)mouseExited:(NSEvent *)event {
    NSDictionary *userInfo = event.trackingArea.userInfo;
    [self updateTrackingAreaWithUserInfo:userInfo eventType:2];

}


/// 更新鼠标UI事件
/// @param userInfo userInfo
/// @param type 1：mouseEntered；2：mouseExited
- (void)updateTrackingAreaWithUserInfo:(NSDictionary *)userInfo eventType:(int)type {
    if (userInfo && [userInfo.allKeys containsObject:@"tag"]) {
        int tag = [userInfo[@"tag"] intValue];
        if (tag == 0) {
            self.topBarView.hidden = (type == 1) ? NO : YES;
            
        } else {
            CGFloat value = type == 1 ? 0.65 : 1.0;
            switch (tag) {
                case 1:
                    [self.stopBtn setAlphaValue:value];
                    break;
                case 2:
                    [self.micBtn setAlphaValue:value];
                    break;
                case 3:
                    [self.camaroBtn setAlphaValue:value];
                    break;
                default:
                    break;
            }
        }
        
        
    }
}

-(void)startAnimation:(id)animationTarget endPoint:(NSPoint)endPoint{
    NSRect startFrame = [animationTarget frame];
    NSRect endFrame = NSMakeRect(endPoint.x, endPoint.y, startFrame.size.width, startFrame.size.height);
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                
                                animationTarget,NSViewAnimationTargetKey,
                                
                                NSViewAnimationFadeInEffect,NSViewAnimationEffectKey,
                                
                                [NSValue valueWithRect:startFrame],NSViewAnimationStartFrameKey,
                                
                                [NSValue valueWithRect:endFrame],NSViewAnimationEndFrameKey, nil];
    
    NSViewAnimation *animation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObject:dictionary]];
//    animation.delegate = self;
    animation.duration = 2.25;
    [animation setAnimationBlockingMode:NSAnimationNonblocking];
    [animation startAnimation];
}


- (void)setupCollectionView {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
//    self.collectionView.selectable = YES;
    
    NSCollectionViewFlowLayout *flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = NSMakeSize(150, 150);
    flowLayout.sectionInset = NSEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = NSCollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = flowLayout;
    
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"PRTCRemoteViewItem" bundle:nil];
    [self.collectionView registerNib:nib forItemWithIdentifier:mainCellID];
      
}



- (void) updateTrackingAreas
{
    for (NSTrackingArea *trackingArea in self.view.trackingAreas) {
        [self.view removeTrackingArea:trackingArea];
    }
    for (NSTrackingArea *trackingArea in self.stopBtn.trackingAreas) {
        [self.view removeTrackingArea:trackingArea];
    }
    for (NSTrackingArea *trackingArea in self.micBtn.trackingAreas) {
        [self.view removeTrackingArea:trackingArea];
    }
    for (NSTrackingArea *trackingArea in self.camaroBtn.trackingAreas) {
        [self.view removeTrackingArea:trackingArea];
    }
    [self setupTrackArea];
    
}
- (void)setupTrackArea {
    

    NSTrackingArea *viewTrackArea = [[NSTrackingArea alloc] initWithRect:self.localView.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways) owner:self userInfo:@{@"tag": @0}];
    [self.view addTrackingArea:viewTrackArea];
    
    
    NSTrackingArea *stopBtnTrackArea = [[NSTrackingArea alloc] initWithRect:self.stopBtn.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways) owner:self userInfo:@{@"tag": @1}];
    [self.stopBtn addTrackingArea:stopBtnTrackArea];
    
    NSTrackingArea *micBtnTrackArea = [[NSTrackingArea alloc] initWithRect:self.micBtn.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways) owner:self userInfo:@{@"tag": @2}];
    [self.micBtn addTrackingArea:micBtnTrackArea];
    
    NSTrackingArea *camaroBtnTrackArea = [[NSTrackingArea alloc] initWithRect:self.camaroBtn.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways) owner:self userInfo:@{@"tag": @3}];
    [self.camaroBtn addTrackingArea:camaroBtnTrackArea];
}


/// 转换stream对象
- (PRTCStream *)createStreamWithInfo:(tPRTCStreamInfo&)info {
    PRTCStream *stream = [PRTCStream new];
    stream.mUserId = [NSString stringWithUTF8String:info.mUserId == NULL ? "" : info.mUserId];
    stream.mStreamId = [NSString stringWithUTF8String:info.mStreamId == NULL ? "" : info.mStreamId];
    stream.mEnableAudio = info.mEnableAudio;
    stream.mEnableVideo = info.mEnableVideo;
    stream.mEnableData = info.mEnableData;
    stream.mMuteVideo = info.mMuteVideo;
    stream.mMuteAudio = info.mMuteAudio;
    stream.mStreamMtype = info.mStreamMtype;
    return stream;
}


@end
