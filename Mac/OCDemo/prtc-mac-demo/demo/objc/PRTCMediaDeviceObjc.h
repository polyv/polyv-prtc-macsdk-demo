//
//  PRTCMediaDeviceObjc.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/4.
//

#import <Foundation/Foundation.h>
#import <PRTCSDK_MAC/PRTCTypeDef.h>
#import <PRTCSDK_MAC/IPRTCEngine.h>
#import <PRTCSDK_MAC/IPRTCMediaDevice.h>
NS_ASSUME_NONNULL_BEGIN


@protocol PRTCRecordingeDelegate <NSObject>

- (void)onMicAudioLevel:(int)volume;

@end

@interface PRTCMediaDeviceObjcAdapter : NSObject

@property(nonatomic, readonly) IPRTCAudioLevelListener *audioLevelListener;

@property(nonatomic, readonly) id<PRTCRecordingeDelegate> delegate;

- (instancetype)initWithAdapter:(id<PRTCRecordingeDelegate>)delegate;

@end



@interface PRTCMediaDeviceObjc : NSObject


+ (instancetype)shared;

+ (void)destory;

///初始化音频模块
///@return 0 succ
- (int)InitAudioMoudle;

///释放音频模块
///@return 0 succ
- (int)UnInitAudioMoudle;

///初始化视频模块
///@return 0 succ
- (int)InitVideoMoudle;

///释放视频模块
///@return 0 succ
- (int)UnInitVideoMoudle;

///获取摄像头数目
///@return 数目
- (int)getCamNums;

///获取录音设备数目
///@return 数目
- (int)getRecordDevNums;

///获取播放设备数目
///@return 数目
- (int)getPlayoutDevNums;

///获取摄像头信息
///@param index id
///@param  info 设备信息
///@return 0 succ
- (int)getVideoDevInfo:(int)index info:(tPRTCDeviceInfo*) info;

///获取录音设备信息
///@param index id
///@param info 设备信息
///@return 0 succ
- (int)getRecordDevInfo:(int)index info:(tPRTCDeviceInfo*)info;

///获取播放设备信息
///@param index id
///@param info 设备信息
///@return 0 succ
- (int)getPlayoutDevInfo:(int)index  info:(tPRTCDeviceInfo*)info;

///获取当前摄像头
///@param out info 设备信息
///@return 0 succ
- (int)getCurCamDev:(tPRTCDeviceInfo*)info;

///获取当前录音设备
///@param out info 设备信息
///@return 0 succ
- (int)getCurRecordDev:(tPRTCDeviceInfo* )info;

///获取当前播放设备
///@param out info 设备信息
///@return 0 succ
- (int)getCurPlayoutDev:(tPRTCDeviceInfo* )info;

///设置视频设备信息
///@param in info 设备信息
///@return 0 succ
- (int)setVideoDevice:(tPRTCDeviceInfo* )info;

///设置录制设备信息
///@param in info 设备信息
///@return 0 succ
- (int)setRecordDevice:(tPRTCDeviceInfo* )info;

///设置播放设备信息
///@param in info 设备信息
///@return 0 succ
- (int)setPlayoutDevice:(tPRTCDeviceInfo* )info;

///获取播放音量
- (int)getPlaybackDeviceVolume:(int *)volume;
- (int)setPlaybackDeviceVolume:(int)volume;

///获取录制音量
- (int)getRecordingDeviceVolume:(int *)volume;
- (int)setRecordingDeviceVolume:(int)volume;

///开启cam测试
///@param  deviceId 设备ID
///@param  profile profile
///@param  hwnd 句柄
///@return 0 succ
- (int)startCamTest:(NSString *)deviceId profile:(ePRTCVideoProfile)profile hwnd:(void*)hwnd;

///停止摄像头测试
///@return 0 succ
- (int)stopCamTest;

///开启录音测试
///@param  audiolevel 回调实例
//- (int)startRecordingDeviceTest:(PRTCAudioLevelListener*)audiolevel;
- (int)startRecordingDeviceTestWithDelegate:(id<PRTCRecordingeDelegate>)delegate;

///停止录音测试
- (int)stopRecordingDeviceTest;

///开启播放设备测试
///@param  testAudioFilePath 文件路径（wav格式文件）
- (int)startPlaybackDeviceTest:(NSString *)testAudioFilePath;

///停止播放设备测试
- (int)stopPlaybackDeviceTest;

///开启摄像头Capture测试
///@param  profile 分辨率
///@param  observer 回调实例
- (int)startCaptureFrame:(ePRTCVideoProfile)profile observer:(IPRTCVideoFrameObserver*)observer;

///停止摄像头Capture测试
- (int)stopCaptureFrame;


@end

NS_ASSUME_NONNULL_END
