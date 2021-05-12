//
//  PRTCEngineObjc.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/4.
//

#import "PRTCEngineObjc.h"
#import <PRTCSDK_MAC/IPRTCEngine.h>

#import "PRTCEngineObjcAdapter.h"

#define PRTCEngineObjcError (-10000)
#define PRTCOcstr2cStr(ocstr) [ocstr UTF8String]

@implementation PRTCEngineObjc
{
    IPRTCEngine *rtcEngine_;
}

static PRTCEngineObjc * _instance = nil;
static dispatch_once_t onceToken;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });

    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
+ (instancetype)shared {
    return [self sharedWithInline:true];
}

+ (instancetype)sharedWithInline:(bool)isInline{
    if (_instance == nil) {
        _instance = [[PRTCEngineObjc alloc] initWithInline:isInline];
    }

    return _instance;
}
+ (instancetype)sharedWithContext:(tPRTCInitContext*)context {
    if (_instance == nil) {
        _instance = [[PRTCEngineObjc alloc] initWithContext:context];
    }
    return _instance;
}

- (instancetype)initWithInline:(bool)isInline
{
    self = [super init];
    if (self) {
        rtcEngine_ = getSharedInstance();
    }
    return self;
}
- (instancetype)initWithContext:(tPRTCInitContext*)context
{
    self = [super init];
    if (self) {
        rtcEngine_ = getSharedInstance();
    }
    return self;
}


///销毁引擎
+ (void)destroy{
    destroySharedInstance();
    _instance = nil;
    onceToken=0l;
    return ;
}
///获取sdk版本
///@return sdk版本号
- (NSString *)getSdkVersion{
    const char *version = rtcEngine_->getSdkVersion();
    return [NSString stringWithUTF8String:version];
}

- (void)setDelegate:(id<PRTCEngineObjcDelegate>)delegate {
    _delegate = delegate;
    // 注册代理
    PRTCEngineObjcAdapter *adapter = [[PRTCEngineObjcAdapter alloc] initWithEngineAdapter:delegate];
    rtcEngine_->regRtcEventListener(adapter.eventListener);
    
}

///设置sdk模式
///@param mode sdk使用模式 正式模式 测试模式
///@return 0 succ
- (int)setSdkMode:(ePRTCSdkMode)mode{
    if (rtcEngine_) {
        return rtcEngine_->setSdkMode(mode);
    }
    return PRTCEngineObjcError;
}

///设置接入方式
///@param from 接入点设置
///@return 0 succ
- (int)setServerGetFrom:(ePRTCServerGetFrom)from{
    if (rtcEngine_) {
        return rtcEngine_->setServerGetFrom(from);
    }
    return PRTCEngineObjcError;
}

///设置频道类别
///@param roomtype 房间类型 大班 小班
///@return 0 succ
- (int)setChannelType:(ePRTCChannelType)roomtype{
    if (rtcEngine_) {
        return rtcEngine_->setChannelType(roomtype);
    }
    return PRTCEngineObjcError;
}

///设置角色
///@param role 推流 拉流 推拉流
///@return 0 succ
- (int)setStreamRole:(ePRTCUserStreamRole)role{
    if (rtcEngine_) {
        return rtcEngine_->setStreamRole(role);
    }
    return PRTCEngineObjcError;
}

///设置日志级别
///@param level 日志级别
- (void)setLogLevel:(ePRTCLogLevel)level{
    if (rtcEngine_) {
        return rtcEngine_->setLogLevel(level);
    }
}

///设置key
///@param seckey 官网控制台的appkey
- (void)setTokenSecKey:(NSString *)seckey{
    if (rtcEngine_) {
        return rtcEngine_->setTokenSecKey(PRTCOcstr2cStr(seckey));
    }
}

///设置自动发布
///@param autoPub 自动发布
///@param autoSub 自动订阅
///@return 0 succ
- (int)setAutoPublish:(bool)autoPub subscribe:(bool)autoSub{
    if (rtcEngine_) {
        return rtcEngine_->setAutoPublishSubscribe(autoPub, autoSub);
    }
    return PRTCEngineObjcError;
}


///设置是否纯音频
///@param audioOnly 是否纯音频
///@return 0 succ
- (int)setAudioOnlyMode:(bool)audioOnly{
    if (rtcEngine_) {
        return rtcEngine_->setAudioOnlyMode(audioOnly);
    }
    return PRTCEngineObjcError;
}

///设置编码
///@param codec 编码类型
///@return 0 succ
- (int)setVideoCodec:(ePRTCVideoCodec)codec{
    if (rtcEngine_) {
        return rtcEngine_->setVideoCodec(codec);
    }
    return PRTCEngineObjcError;
}

///该方法用于注册语音观测器对象
///@param observer 监听
- (void)registerAudioFrameObserver:(IPRTCAudioFrameObserver *)observer{
    if (rtcEngine_) {
        return rtcEngine_->registerAudioFrameObserver(observer);
    }
}

///该方法用于注册视频观测器对象
///@param observer 监听
- (void)registerVideoFrameObserver:(IPRTCVideoFrameObserver *)observer{
    if (rtcEngine_) {
        return rtcEngine_->registerVideoFrameObserver(observer);
    }
}

///开启rtsp推流
///@param type 媒体类型
///@param enable 是否使用扩展rtsp流
///@param rtspurl rtsp地址
///@return 0 succ
- (int)enableExtendRtspVideocapture:(ePRTCMeidaType)type enable:(bool)enable rtspurl:(NSString *)rtspurl{
    if (rtcEngine_) {
        return rtcEngine_->enableExtendRtspVideocapture(type, enable, PRTCOcstr2cStr(rtspurl));
    }
    return PRTCEngineObjcError;
}

///开启外部采集视频
///@param enable 是否使用扩展的外部采集摄像头
///@param videocapture 外部视频源
///@return 0 succ
- (int)enableExtendVideocapture:(bool)enable source:(IPRTCExtendVideoCaptureSource *)videocapture{
    if (rtcEngine_) {
        return rtcEngine_->enableExtendVideocapture(enable, videocapture);
    }
    return PRTCEngineObjcError;
}

///初始化外部音频源
///@param audiocapture 外部音频源
///@return 0 succ
- (int)initExtendAudioSource:(IPRTCExtendAudioCaptureSource *)audiocapture{
    if (rtcEngine_) {
        return rtcEngine_->initExtendAudioSource(audiocapture);
    }
    return PRTCEngineObjcError;
}

///开启外部采集音频
///@param enable 是否使用扩展的外部采集音频
///@param audiocapture 外部音频源(note :必须先初始化initExtendAudioSource一次)
///@return 0 succ
- (int)enableExtendAudiocapture:(bool)enable source:(IPRTCExtendAudioCaptureSource*)audiocapture{
    if (rtcEngine_) {
        return rtcEngine_->enableExtendAudiocapture(enable, audiocapture);
    }
    return PRTCEngineObjcError;
}

///开启混音
///@param filepath 文件路径
///@param replace 是否替代麦克风
///@param loop 是否循环
///@param musicvol 音量
///@return 0 succ
- (int)startAudioMixing:(NSString*)filepath replaceAudio:(bool)replace loop:(bool)loop musicvol:(float)musicvol{
    if (rtcEngine_) {
        return rtcEngine_->startAudioMixing(PRTCOcstr2cStr(filepath), replace, loop, musicvol);
    }
    return PRTCEngineObjcError;
}

///停止混音
///@return 0 succ
- (int)stopAudioMixing{
    if (rtcEngine_) {
        return rtcEngine_->stopAudioMixing();
    }
    return PRTCEngineObjcError;
}

///注册音频接收回调
///@param callback 派生自IPRTCAudioFrameCallback 的实例 (note :在setChanleType后调用)
- (void)regAudioFrameCallback:(IPRTCAudioFrameCallback*)callback{
    if (rtcEngine_) {
        return rtcEngine_->regAudioFrameCallback(callback);
    }
}

///注册设备插拔通知回调
///@param callback 派生自IPRTCDeviceChanged 的实例
- (void)regDeviceChangeCallback:(IPRTCDeviceChanged*)callback{
    if (rtcEngine_) {
        return rtcEngine_->regDeviceChangeCallback(callback);
    }
}

///加入房间
///@param auth 鉴权信息
///@return 0 succ
- (int)joinChannel:(tPRTCAuth&)auth{
    if (rtcEngine_) {
        return rtcEngine_->joinChannel(auth);
    }
    return PRTCEngineObjcError;
}

///离开房间
///@return 0 succ
- (int)leaveChannel{
    if (rtcEngine_) {
        return rtcEngine_->leaveChannel();
    }
    return PRTCEngineObjcError;
}

///获取桌面数目
///@return 数目
- (int)getDesktopNums{
    if (rtcEngine_) {
        return rtcEngine_->getDesktopNums();
    }
    return PRTCEngineObjcError;
}

///获取桌面信息
///@param pos 位置
///@param [out] info 桌面信息
///@return 0 succ
- (int)getDesktopInfo:(int)pos desktopInfo:(tPRTCDeskTopInfo&)info{
    if (rtcEngine_) {
        return rtcEngine_->getDesktopInfo(pos, info);
    }
    return PRTCEngineObjcError;
}

///获取窗口数目
- (int)getWindowNums{
    if (rtcEngine_) {
        return rtcEngine_->getWindowNums();
    }
    return PRTCEngineObjcError;
}

///获取桌面窗口信息
///@param pos 位置
///@param [out] info 窗口信息
///@return 0 succ
- (int)getWindowInfo:(int)pos windowInfo:(tPRTCDeskTopInfo&)info{
    if (rtcEngine_) {
        return rtcEngine_->getWindowInfo(pos, info);
    }
    return PRTCEngineObjcError;
}

///设置桌面分享类型
///@param desktoptype 卓面类型
///@return 0 succ
- (int)setUseDesktopCapture:(ePRTCDesktopType)desktoptype{
    if (rtcEngine_) {
        return rtcEngine_->setUseDesktopCapture(desktoptype);
    }
    return PRTCEngineObjcError;
}

///设置桌面分享profile
///@param profile 分辨率
- (void)setDesktopProfile:(ePRTCScreenProfile)profile{
    if (rtcEngine_) {
        return rtcEngine_->setDesktopProfile(profile);
    }
}

///设置桌面分享参数
///@param pgram 分享参数
- (void)setCaptureScreenPagrams:(tPRTCScreenPargram&)pgram{
    if (rtcEngine_) {
        return rtcEngine_->setCaptureScreenPagrams(pgram);
    }
}

///设置加入房间前是否开启摄像头
///@param mute 是否禁掉视频  true：禁止 false:否
///@return 0 succ
- (int)muteCamBeforeJoin:(bool)mute{
    if (rtcEngine_) {
        return rtcEngine_->muteCamBeforeJoin(mute);
    }
    return PRTCEngineObjcError;
}

///设置加入房间前是否mute mic
///@param mute 是否禁掉mic  true：禁止 false:否
///@return 0 succ
- (int)muteMicBeforeJoin:(bool)mute{
    if (rtcEngine_) {
        return rtcEngine_->muteMicBeforeJoin(mute);
    }
    return PRTCEngineObjcError;
}

///设置订阅成功后是否mute摄像头
///@param mute 是否禁掉视频  true：禁止 false:否
///@return 0 succ
- (int)muteRemoteCamBeforeSub:(bool)mute{
    if (rtcEngine_) {
        return rtcEngine_->muteRomoteCamBeforeSub(mute);
    }
    return PRTCEngineObjcError;
}

///设置订阅成功后是否mute mic
///@param mute 是否禁掉mic  true：禁止 false:否
///@return 0 succ
- (int)muteRemoteMicBeforeSub:(bool)mute{
    if (rtcEngine_) {
        return rtcEngine_->muteRomoteMicBeforeSub(mute);
    }
    return PRTCEngineObjcError;
}

///设置编码发送视频质量
///@param profile 分辨率
///@param videoconfig video配置
- (void)setVideoProfile:(ePRTCVideoProfile)profile config:(tPRTCVideoConfig&)videoconfig{
    if (rtcEngine_) {
        return rtcEngine_->setVideoProfile(profile, videoconfig);
    }
}

///设置采集渲染视频分辨率
///@param profile 分辨率
- (void)setVideoCaptureProfile:(ePRTCVideoProfile)profile{
    if (rtcEngine_) {
        return rtcEngine_->setVideoCaptureProfile(profile);
    }
}

///切换摄像头
///@param info 设备信息
///@return 0 succ
- (int)switchCamera:(tPRTCDeviceInfo&)info{
    if (rtcEngine_) {
        return rtcEngine_->switchCamera(info);
    }
    return PRTCEngineObjcError;
}

///开关本地视频采集
///@param enable 开启关闭本地视频采集
///@return 0 succ
- (int)enableLocalCamera:(bool)enable{
    if (rtcEngine_) {
        return rtcEngine_->enableLocalCamera(enable);
    }
    return PRTCEngineObjcError;
}

///发布
///@param type 媒体类型 摄像头或者桌面
///@param hasvideo 是否带视频
///@param hasaudio 是否带音频
///@return 0 succ
- (int)publish:(ePRTCMeidaType)type hasvideo:(bool)hasvideo hasaudio:(bool)hasaudio{
    if (rtcEngine_) {
        return rtcEngine_->publish(type, hasvideo, hasaudio);
    }
    return PRTCEngineObjcError;
}

///取消发布
///@param type 媒体类型
///@return 0 succ
- (int)unPublish:(ePRTCMeidaType)type{
    if (rtcEngine_) {
        return rtcEngine_->unPublish(type);
    }
    return PRTCEngineObjcError;
}

///开始预览
///@param view 预览的veiw信息
///@return 0 succ
- (int)startPreview:(tPRTCVideoCanvas&)view{
    if (rtcEngine_) {
        return rtcEngine_->startPreview(view);
    }
    return PRTCEngineObjcError;
}

///停止预览
///@param view 预览的veiw信息
///@return 0 succ
- (int)stopPreview:(tPRTCVideoCanvas&)view{
    if (rtcEngine_) {
        return rtcEngine_->stopPreview(view);
    }
    return PRTCEngineObjcError;
}

/// mute本地麦克
/// @param mute 是否禁用
/// @param streamtype 默认为PRTC_MEDIATYPE_VIDEO
- (int)muteLocalMic:(bool)mute streamType:(ePRTCMeidaType)streamtype{
    if (rtcEngine_) {
        return rtcEngine_->muteLocalMic(mute, streamtype);
    }
    return PRTCEngineObjcError;
}

///mute本地视频
///@param mute true:是 false:否
///@param streamtype 媒体类型
///@return 0 succ
- (int)muteLocalVideo:(bool)mute streamtype:(ePRTCMeidaType)streamtype{
    if (rtcEngine_) {
        return rtcEngine_->muteLocalVideo(mute, streamtype);
    }
    return PRTCEngineObjcError;
}

///订阅
///@param info 订阅的流
///@return 0 succ
- (int)subscribe:(tPRTCStreamInfo&)info{
    if (rtcEngine_) {
        return rtcEngine_->subscribe(info);
    }
    return PRTCEngineObjcError;
}

///取消订阅
///@param info 取消订阅的流
///@return 0 succ
- (int)unSubscribe:(tPRTCStreamInfo&)info{
    if (rtcEngine_) {
        return rtcEngine_->unSubscribe(info);
    }
    return PRTCEngineObjcError;
}


///开启远端渲染
///@param view 开启远端渲染的视图信息
///@return 0 succ
- (int)startRemoteView:(tPRTCVideoCanvas&)view{
    if (rtcEngine_) {
        return rtcEngine_->startRemoteView(view);
    }
    return PRTCEngineObjcError;
}


///停止远端渲染
///@param view 视图信息
///@return 0 succ
- (int)stopRemoteView:(tPRTCVideoCanvas&)view{
    if (rtcEngine_) {
        return rtcEngine_->stopRemoteView(view);
    }
    return PRTCEngineObjcError;
}

///mute远端音频
///@param info mute流信息
///@param mute true:是 false:否
///@return 0 succ
- (int)muteRemoteAudio:(tPRTCMuteSt&)info mute:(bool)mute{
    if (rtcEngine_) {
        return rtcEngine_->muteRemoteAudio(info, mute);
    }
    return PRTCEngineObjcError;
}


///mute 远端视频
///@param info mute流信息
///@param mute true:是 false:否
///@return 0 succ
- (int)muteRemoteVideo:(tPRTCMuteSt&)info mute:(bool)mute{
    if (rtcEngine_) {
        return rtcEngine_->muteRemoteVideo(info, mute);
    }
    return PRTCEngineObjcError;
}


///是否开启播放
///@param enable true:是 false:否
///@return 0 succ
- (int)enableAllAudioPlay:(bool)enable{
    if (rtcEngine_) {
        return rtcEngine_->enableAllAudioPlay(enable);
    }
    return PRTCEngineObjcError;
}


///开始录制
///@param recordconfig 录制配置
///@return 0 succ
- (int)startRecord:(tPRTCRecordConfig&)recordconfig{
    if (rtcEngine_) {
        return rtcEngine_->startRecord(recordconfig);
    }
    return PRTCEngineObjcError;
}

///停止录制
///@return 0 succ
- (int)stopRecord{
    if (rtcEngine_) {
        return rtcEngine_->stopRecord();
    }
    return PRTCEngineObjcError;
}

///设置摄像头是否开启
///@param enable true:是 false:否
///@return 0 succ
- (int)configLocalCameraPublish:(bool)enable{
    if (rtcEngine_) {
        return rtcEngine_->configLocalCameraPublish(enable);
    }
    return PRTCEngineObjcError;
}

///本地摄像头是否开启
///@return true false
- (bool)isLocalCameraPublishEnabled{
    if (rtcEngine_) {
        return rtcEngine_->isLocalCameraPublishEnabled();
    }
    return PRTCEngineObjcError;
}

///设置分享桌面开启
///@param enable true:是 false:否
///@return 0 succ
- (int)configLocalScreenPublish:(bool)enable{
    if (rtcEngine_) {
        return rtcEngine_->configLocalScreenPublish(enable);
    }
    return PRTCEngineObjcError;
}

///分享桌面是否开启
///@return true false
- (bool)isLocalScreenPublishEnabled{
    if (rtcEngine_) {
        return rtcEngine_->isLocalScreenPublishEnabled();
    }
    return PRTCEngineObjcError;
}

///配置本地音频发布
///@param enable true:是 false:否
///@return 0 succ
- (int)configLocalAudioPublish:(bool)enable{
    if (rtcEngine_) {
        return rtcEngine_->configLocalAudioPublish(enable);
    }
    return PRTCEngineObjcError;
}

///本地发布是否禁止
///@return true false
- (bool)isLocalAudioPublishEnabled{
    if (rtcEngine_) {
        return rtcEngine_->isLocalAudioPublishEnabled();
    }
    return PRTCEngineObjcError;
}

///是否自动发布
///@return true false
- (bool)isAutoPublish{
    if (rtcEngine_) {
        return rtcEngine_->isAutoPublish();
    }
    return PRTCEngineObjcError;
}

///是否自动订阅
///@return true false
- (bool)isAutoSubscribe{
    if (rtcEngine_) {
        return rtcEngine_->isAutoSubscribe();
    }
    return PRTCEngineObjcError;
}

///是否纯音频
///@return true false
- (bool)isAudioOnly{
    if (rtcEngine_) {
        return rtcEngine_->isAudioOnly();
    }
    return PRTCEngineObjcError;
}

///旁路推流
///@param url cdn地址
///@param config 转推配置(note: 初始模板会自动选择mlayouts[0]，布局列表最大支持3种在房间内切换)
///@return 0 succ
- (int)addPublishStreamUrl:(NSString*)url config:(tPRTCTranscodeConfig *)config{
    if (rtcEngine_) {
        return rtcEngine_->addPublishStreamUrl(PRTCOcstr2cStr(url), config);
    }
    return PRTCEngineObjcError;
}

///更新转推设置
///@param url cdn 地址
///@param config 转推更新设置
///@return 0 succ
- (int)updateTranscodeConfig:(NSString*)url config:(tPRTCTranscodeConfig *)config{
    if (rtcEngine_) {
        return rtcEngine_->updateTranscodeConfig(PRTCOcstr2cStr(url), config);
    }
    return PRTCEngineObjcError;
}

///停止旁路推流
///@param url cdn地址
///@return 0 succ
- (int)removePublishStreamUrl:(NSString*)url{
    if (rtcEngine_) {
        return rtcEngine_->removePublishStreamUrl(PRTCOcstr2cStr(url));
    }
    return PRTCEngineObjcError;
}


///更新旁路推流合流的流
///@param cmd rtmp操作类型
///@param streams 转推的流类型
///@param length 转推的流长度
///@return 0 succ
- (int)updateRtmpMixStream:(ePRTCRtmpOpration)cmd streams:(tPRTCRelayStream*)streams length:(int)length{
    if (rtcEngine_) {
        return rtcEngine_->updateRtmpMixStream(cmd, streams, length);
    }
    return PRTCEngineObjcError;
}

/// 设置mute后的水印图 yuv420格式 内部自动缩放
/// @param image rgb格式的字节数组
/// @param width 宽
/// @param height 高
- (int)setMuteBackImage:(const unsigned char*)image width:(int)width height:(int)height{
    if (rtcEngine_) {
        return rtcEngine_->setMuteBackImage(image, width, height);
    }
    return PRTCEngineObjcError;
}

///开启系统采集音
///@param enable true:开启 fasle:关闭
///@return 0 succ
- (int)enableCapturePlayBack:(bool)enable{
    if (rtcEngine_) {
        return rtcEngine_->enableCapturePlayBack(enable);
    }
    return PRTCEngineObjcError;
}

///发送自定义消息
- (int)sendMessage:(NSString*)msg{
    if (rtcEngine_) {
        return rtcEngine_->sendMessage(PRTCOcstr2cStr(msg));
    }
    return PRTCEngineObjcError;
}

///获取混音文件播放总时长
- (int)getAudioMixingDuration{
    if (rtcEngine_) {
        return PRTCEngineObjcError;//rtcEngine_->getAudioMixingDuration();
    }
    return PRTCEngineObjcError;
}

///获取混音当前播放进度
- (int)getAudioMixingCurrentPosition{
    if (rtcEngine_) {
        return PRTCEngineObjcError;//rtcEngine_->getAudioMixingCurrentPosition();
    }
    return PRTCEngineObjcError;
}

///恢复当前混音
- (int)resumeAudioMixing{
    if (rtcEngine_) {
        return PRTCEngineObjcError;//rtcEngine_->resumeAudioMixing();
    }
    return PRTCEngineObjcError;
}

///暂停当前混音
- (int)pauseAudioMixing{
    if (rtcEngine_) {
        return PRTCEngineObjcError; //rtcEngine_->pauseAudioMixing();
    }
    return PRTCEngineObjcError;
}

///设置播放进度
- (int)setAudioMixingPosition:(int)position{
    if (rtcEngine_) {
        return PRTCEngineObjcError;//rtcEngine_->setAudioMixingPosition(position);
    }
    return PRTCEngineObjcError;
}

///更新混音音量
- (int)updateAudioMixingVolume:(int)volume{
    if (rtcEngine_) {
        return PRTCEngineObjcError;//rtcEngine_->updateAudioMixingVolume(volume);
    }
    return PRTCEngineObjcError;
}

@end
 
