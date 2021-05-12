//
//  PRTCEngineObjc.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/4.
//

#import <Foundation/Foundation.h>
#import <PRTCSDK_MAC/PRTCTypeDef.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PRTCEngineObjcDelegate <NSObject>
- (void)onServerDisconnect;
///加入房间回调
///@param code 错误码  0成功
///@param msg 错误信息
///@param uid 用户id
///@param roomid 房间id
- (void)onJoinRoom:(int)code msg:(NSString*)msg uid:(NSString*)uid roomid:(NSString*) roomid;

///离开房间回调
///@param code 错误码  0成功
///@param msg 错误信息
///@param uid 用户id
///@param roomid 房间id
- (void)onLeaveRoom:(int)code msg:(NSString*)msg uid:(NSString*)uid roomid:(NSString*) roomid;

///断线重连回调
///@param uid 用户id
///@param roomid 房间id
- (void)onRejoining:(NSString*)uid roomid:(NSString*) roomid;

///重新加入房间成功回调
///@param uid 用户id
///@param roomid 房间id
- (void)onReJoinRoom:(NSString*)uid roomid:(NSString*) roomid;

///本地流发布回调
///@param code 错误码  0 succ
///@param msg 本地发布错误信息
///@param info 发布成功后本地流信息
- (void)onLocalPublish:(int)code msg:(NSString*)msg info:(tPRTCStreamInfo&)info;

///本地流取消发布回调
///@param code 错误码  0 succ
///@param msg 本地发布错误信息
///@param info 取消发布成功后本地流信息
- (void)onLocalUnPublish:(int)code msg:(NSString*)msg info:(tPRTCStreamInfo&)info;

///远端用户加入回调
///@param uid 远端用户id
- (void)onRemoteUserJoin:(NSString*)uid;

///远端用户离开回调
///@param uid 远端用户id
///@param reason 离开原因
- (void)onRemoteUserLeave:(NSString*)uid reason:(int)reson;

///远端流发布回调
///@param info 远端流信息
- (void)onRemotePublish:(tPRTCStreamInfo&)info;

///远端流取消发布回调
///@param info 远端流信息
- (void)onRemoteUnPublish:(tPRTCStreamInfo&)info;

///订阅回调
///@param code 订阅结果 0 succ
///@param msg 订阅提示信息
///@param info 订阅流信息
- (void)onSubscribeResult:(int)code msg:(NSString *)msg info:(tPRTCStreamInfo&)info;

///取消订阅回调
///@param code 取消订阅结果 0 succ
///@param msg 订阅提示信息
///@param info 订阅流信息
- (void)onUnSubscribeResult:(int)code msg:(NSString*)msg info:(tPRTCStreamInfo&)info;

///本地mute回调
///@param code mute回调结果 0 succ
///@param msg  提示信息
///@param mediatype 媒体类型
///@param tracktype track类型
///@param mute mute状态
- (void)onLocalStreamMuteRsp:(int)code msg:(NSString*)msg mediatype:(ePRTCMeidaType)mediatype tracktype:(ePRTCTrackType)tracktype mute:(bool)mute ;

///远端mute回调
///@param code mute回调结果 0 succ
///@param msg  提示信息
///@param uid  远端用户id
///@param mediatype 媒体类型
///@param tracktype track类型
///@param mute mute状态
- (void)onRemoteStreamMuteRsp:(int)code msg:(NSString*)msg uid:(NSString*)uid mediatype:(ePRTCMeidaType)mediatype tracktype:(ePRTCTrackType)tracktype mute:(bool)mute;

///远端音频轨或者视频轨状态回调
///@param uid  远端用户id
///@param mediatype 媒体类型
///@param tracktype track类型
///@param mute mute状态
- (void)onRemoteTrackNotify:(NSString*)uid mediatype:(ePRTCMeidaType)mediatype tracktype:(ePRTCTrackType)tracktype mute:(bool)mute;

///开启录制回调
///@param code  0 succ
///@param msg 错误提示信息
///@param info 录制信息
- (void)onStartRecord:(int)code msg:(NSString*)msg info:(tPRTCRecordInfo&)info;

///停止录制回调
///@param code  0 succ 0代表主动停止成功 非0代表异常停止需要重新开启
///@param msg 错误提示信息
///@param recordid 录制ID
- (void)onStopRecord:(int)code msg:(NSString *)msg recordid:(NSString*)recordid;

///本地数据统计回调
///@param rtstats 统计信息
- (void)onSendRTCStats:(tPRTCStreamStats&)rtstats;

///远端数据统计回调
///@param rtstats 统计信息
- (void)onRemoteRTCStats:(tPRTCStreamStats)rtstats;

///远端音频能量回调
///@param uid 用户ID
///@param volume 音量大小
- (void)onRemoteAudioLevel:(NSString*)uid volume:(int)volume;

///网络评分回调
///@param uid 用户ID
///@param rtype 网络上下型类型
///@param Quality 评分
- (void)onNetworkQuality:(NSString*)uid quality:(ePRTCNetworkQuality&)rtype qualityType:(ePRTCQualityType&)Quality;

///旁推状态回调
///@param state rtmp状态
///@param url cdn地址
///@param code 错误码
- (void)onRtmpStreamingStateChanged:(int)state url:(NSString*)url code:(int)code;

///旁推更新混合流回调
///@param cmd 操作类型
///@param code 错误码
///@param msg 错误信息
- (void)onRtmpUpdateMixStreamRes:(ePRTCRtmpOpration&)cmd code:(int)code msg:(NSString*) msg;

///设备报错回调
///@param code 设备报错回调
- (void)onCaptureError:(int)code detail:(int)detail;

///本地音频能量回调
///@param volume 音量大小
- (void)onLocalAudioLevel:(int)volume;


///远端音频播放首帧回调
///@param uid 用户id
///@param elapsed 从加入房间到收到远端音频距离的时间
- (void)onFirstRemoteAudioFrame:(NSString*)uid elapsed:(int)elapsed;


///远端视频首帧回调
///@param uid 用户id
///@param width 宽度
///@param height 高度
///@param elapsed 从加入房间到收到远端视频渲染距离的时间
- (void)onFirstRemoteVideoFrame:(NSString*)uid width:(int)width height:(int)height elapsed:(int)elapsed;

///自定义消息接口发送结果
/// @param code 错误
/// @param msg
- (void)onSendMsgRsp:(int)code msg:(NSString*)msg;

///广播消息通知
///@param uid 用户id
///@param msg 用户消息
- (void)onBroadMsgNotify:(NSString*)uid msg:(NSString *)msg;

///踢人通知
///@param code 错误码
- (void)onKickoff:(int)code;

///警告回调
///@param warn 错误码
- (void)onWarning:(int)warn;

///错误回调
///@param error 错误码
- (void)onError:(int)error;

@end


@interface PRTCEngineObjc : NSObject

@property(nonatomic,weak) id<PRTCEngineObjcDelegate> delegate;


/// 创建引擎，默认true，自采集
+ (instancetype)shared;

/// 创建引擎
/// @param isInline 是否采用自采集
+ (instancetype)sharedWithInline:(bool)isInline;

/// 创建引擎
/// @param context 配置环境参数
+ (instancetype)sharedWithContext:(tPRTCInitContext*)context;

///销毁引擎
+ (void)destroy;
///获取sdk版本
///@return sdk版本号
- (NSString *)getSdkVersion;

///设置sdk模式
///@param mode sdk使用模式 正式模式 测试模式
///@return 0 succ
- (int)setSdkMode:(ePRTCSdkMode)mode;

///设置接入方式
///@param from 接入点设置
///@return 0 succ
- (int)setServerGetFrom:(ePRTCServerGetFrom)from;

///设置频道类别
///@param roomtype 房间类型 大班 小班
///@return 0 succ
- (int)setChannelType:(ePRTCChannelType)roomtype;

///设置角色
///@param role 推流 拉流 推拉流
///@return 0 succ
- (int)setStreamRole:(ePRTCUserStreamRole)role;

///设置日志级别
///@param level 日志级别
- (void)setLogLevel:(ePRTCLogLevel)level;

///设置key
///@param seckey 官网控制台的appkey
- (void)setTokenSecKey:(NSString *)seckey;

///设置自动发布
///@param autoPub 自动发布
///@param autoSub 自动订阅
///@return 0 succ
- (int)setAutoPublish:(bool)autoPub subscribe:(bool)autoSub;


///设置是否纯音频
///@param audioOnly 是否纯音频
///@return 0 succ
- (int)setAudioOnlyMode:(bool)audioOnly;

///设置编码
///@param codec 编码类型
///@return 0 succ
- (int)setVideoCodec:(ePRTCVideoCodec)codec;

///该方法用于注册语音观测器对象
///@param observer 监听
- (void)registerAudioFrameObserver:(IPRTCAudioFrameObserver *)observer;

///该方法用于注册视频观测器对象
///@param observer 监听
- (void)registerVideoFrameObserver:(IPRTCVideoFrameObserver *)observer;

///开启rtsp推流
///@param type 媒体类型
///@param enable 是否使用扩展rtsp流
///@param rtspurl rtsp地址
///@return 0 succ
- (int)enableExtendRtspVideocapture:(ePRTCMeidaType)type enable:(bool)enable rtspurl:(NSString *)rtspurl;

///开启外部采集视频
///@param enable 是否使用扩展的外部采集摄像头
///@param videocapture 外部视频源
///@return 0 succ
- (int)enableExtendVideocapture:(bool)enable source:(IPRTCExtendVideoCaptureSource *)videocapture;

///初始化外部音频源
///@param audiocapture 外部音频源
///@return 0 succ
- (int)initExtendAudioSource:(IPRTCExtendAudioCaptureSource *)audiocapture;

///开启外部采集音频
///@param enable 是否使用扩展的外部采集音频
///@param audiocapture 外部音频源(note :必须先初始化initExtendAudioSource一次)
///@return 0 succ
- (int)enableExtendAudiocapture:(bool)enable source:(IPRTCExtendAudioCaptureSource*)audiocapture;

///开启混音
///@param filepath 文件路径
///@param replace 是否替代麦克风
///@param loop 是否循环
///@param musicvol 音量
///@return 0 succ
- (int)startAudioMixing:(NSString*)filepath replaceAudio:(bool)replace loop:(bool)loop musicvol:(float)musicvol;

///停止混音
///@return 0 succ
- (int)stopAudioMixing;

///注册音频接收回调
///@param callback 派生自IPRTCAudioFrameCallback 的实例 (note :在setChanleType后调用)
- (void)regAudioFrameCallback:(IPRTCAudioFrameCallback*)callback;

///注册设备插拔通知回调
///@param callback 派生自IPRTCDeviceChanged 的实例
- (void)regDeviceChangeCallback:(IPRTCDeviceChanged*)callback;

///加入房间
///@param auth 鉴权信息
///@return 0 succ
- (int)joinChannel:(tPRTCAuth&)auth;

///离开房间
///@return 0 succ
- (int)leaveChannel;

///获取桌面数目
///@return 数目
- (int)getDesktopNums;

///获取桌面信息
///@param pos 位置
///@param [out] info 桌面信息
///@return 0 succ
- (int)getDesktopInfo:(int)pos desktopInfo:(tPRTCDeskTopInfo&)info;

///获取窗口数目
- (int)getWindowNums;

///获取桌面窗口信息
///@param pos 位置
///@param [out] info 窗口信息
///@return 0 succ
- (int)getWindowInfo:(int)pos windowInfo:(tPRTCDeskTopInfo&)info;

///设置桌面分享类型
///@param desktoptype 卓面类型
///@return 0 succ
- (int)setUseDesktopCapture:(ePRTCDesktopType)desktoptype;

///设置桌面分享profile
///@param profile 分辨率
- (void)setDesktopProfile:(ePRTCScreenProfile)profile;

///设置桌面分享参数
///@param pgram 分享参数
- (void)setCaptureScreenPagrams:(tPRTCScreenPargram&)pgram;

///设置加入房间前是否开启摄像头
///@param mute 是否禁掉视频  true：禁止 false:否
///@return 0 succ
- (int)muteCamBeforeJoin:(bool)mute;

///设置加入房间前是否mute mic
///@param mute 是否禁掉mic  true：禁止 false:否
///@return 0 succ
- (int)muteMicBeforeJoin:(bool)mute;

///设置订阅成功后是否mute摄像头
///@param mute 是否禁掉视频  true：禁止 false:否
///@return 0 succ
- (int)muteRemoteCamBeforeSub:(bool)mute;

///设置订阅成功后是否mute mic
///@param mute 是否禁掉mic  true：禁止 false:否
///@return 0 succ
- (int)muteRemoteMicBeforeSub:(bool)mute;

///设置编码发送视频质量
///@param profile 分辨率
///@param videoconfig video配置
- (void)setVideoProfile:(ePRTCVideoProfile)profile config:(tPRTCVideoConfig&)videoconfig;

///设置采集渲染视频分辨率
///@param profile 分辨率
- (void)setVideoCaptureProfile:(ePRTCVideoProfile)profile;

///切换摄像头
///@param info 设备信息
///@return 0 succ
- (int)switchCamera:(tPRTCDeviceInfo&)info;

///开关本地视频采集
///@param enable 开启关闭本地视频采集
///@return 0 succ
- (int)enableLocalCamera:(bool)enable;

///发布
///@param type 媒体类型 摄像头或者桌面
///@param hasvideo 是否带视频
///@param hasaudio 是否带音频
///@return 0 succ
- (int)publish:(ePRTCMeidaType)type hasvideo:(bool)hasvideo hasaudio:(bool)hasaudio;

///取消发布
///@param type 媒体类型
///@return 0 succ
- (int)unPublish:(ePRTCMeidaType)type;

///开始预览
///@param view 预览的veiw信息
///@return 0 succ
- (int)startPreview:(tPRTCVideoCanvas&)view;

///停止预览
///@param view 预览的veiw信息
///@return 0 succ
- (int)stopPreview:(tPRTCVideoCanvas&)view;

/// mute本地麦克
/// @param mute 是否禁用
/// @param streamtype 默认为PRTC_MEDIATYPE_VIDEO
- (int)muteLocalMic:(bool)mute streamType:(ePRTCMeidaType)streamtype;

///mute本地视频
///@param mute true:是 false:否
///@param streamtype 媒体类型
///@return 0 succ
- (int)muteLocalVideo:(bool)mute streamtype:(ePRTCMeidaType)streamtype;

///订阅
///@param info 订阅的流
///@return 0 succ
- (int)subscribe:(tPRTCStreamInfo&)info;

///取消订阅
///@param info 取消订阅的流
///@return 0 succ
- (int)unSubscribe:(tPRTCStreamInfo&)info;


///开启远端渲染
///@param view 开启远端渲染的视图信息
///@return 0 succ
- (int)startRemoteView:(tPRTCVideoCanvas&)view;


///停止远端渲染
///@param view 视图信息
///@return 0 succ
- (int)stopRemoteView:(tPRTCVideoCanvas&)view;

///mute远端音频
///@param info mute流信息
///@param mute true:是 false:否
///@return 0 succ
- (int)muteRemoteAudio:(tPRTCMuteSt&)info mute:(bool)mute;


///mute 远端视频
///@param info mute流信息
///@param mute true:是 false:否
///@return 0 succ
- (int)muteRemoteVideo:(tPRTCMuteSt&)info mute:(bool)mute;


///是否开启播放
///@param enable true:是 false:否
///@return 0 succ
- (int)enableAllAudioPlay:(bool)enable;


///开始录制
///@param recordconfig 录制配置
///@return 0 succ
- (int)startRecord:(tPRTCRecordConfig&)recordconfig;

///停止录制
///@return 0 succ
- (int)stopRecord;

///设置摄像头是否开启
///@param enable true:是 false:否
///@return 0 succ
- (int)configLocalCameraPublish:(bool)enable;

///本地摄像头是否开启
///@return true false
- (bool)isLocalCameraPublishEnabled;

///设置分享桌面开启
///@param enable true:是 false:否
///@return 0 succ
- (int)configLocalScreenPublish:(bool)enable;

///分享桌面是否开启
///@return true false
- (bool)isLocalScreenPublishEnabled;

///配置本地音频发布
///@param enable true:是 false:否
///@return 0 succ
- (int)configLocalAudioPublish:(bool)enable;

///本地发布是否禁止
///@return true false
- (bool)isLocalAudioPublishEnabled;

///是否自动发布
///@return true false
- (bool)isAutoPublish;

///是否自动订阅
///@return true false
- (bool)isAutoSubscribe;

///是否纯音频
///@return true false
- (bool)isAudioOnly;

///旁路推流
///@param url cdn地址
///@param config 转推配置(note: 初始模板会自动选择mlayouts[0]，布局列表最大支持3种在房间内切换)
///@return 0 succ
- (int)addPublishStreamUrl:(NSString*)url config:(tPRTCTranscodeConfig *)config;

///更新转推设置
///@param url cdn 地址
///@param config 转推更新设置
///@return 0 succ
- (int)updateTranscodeConfig:(NSString*)url config:(tPRTCTranscodeConfig *)config;

///停止旁路推流
///@param url cdn地址
///@return 0 succ
- (int)removePublishStreamUrl:(NSString*)url;


///更新旁路推流合流的流
///@param cmd rtmp操作类型
///@param streams 转推的流类型
///@param length 转推的流长度
///@return 0 succ
- (int)updateRtmpMixStream:(ePRTCRtmpOpration)cmd streams:(tPRTCRelayStream*)streams length:(int)length;

/// 设置mute后的水印图 yuv420格式 内部自动缩放
/// @param image rgb格式的字节数组
/// @param width 宽
/// @param height 高
- (int)setMuteBackImage:(const unsigned char*)image width:(int)width height:(int)height;

///开启系统采集音
///@param enable true:开启 fasle:关闭
///@return 0 succ
- (int)enableCapturePlayBack:(bool)enable;

///发送自定义消息
- (int)sendMessage:(NSString*)msg;

///获取混音文件播放总时长
- (int)getAudioMixingDuration;

///获取混音当前播放进度
- (int)getAudioMixingCurrentPosition;

///恢复当前混音
- (int)resumeAudioMixing;

///暂停当前混音
- (int)pauseAudioMixing;

///设置播放进度
- (int)setAudioMixingPosition:(int)position;

///更新混音音量
- (int)updateAudioMixingVolume:(int)volume;

@end

NS_ASSUME_NONNULL_END
