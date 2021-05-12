//
//  PRTCMediaDeviceObjc.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/4.
//

#import "PRTCMediaDeviceObjc.h"

#define PRTCMediaDeviceObjcError (-10000)

class  PRTCAudioLevelObserve: public IPRTCAudioLevelListener
{
public:
    PRTCAudioLevelObserve(PRTCMediaDeviceObjcAdapter *adapter) {
        adapter_ = adapter;
    }
    
    ///回调音频能量
    virtual void onMicAudioLevel(int volume) {
        if ([adapter_.delegate respondsToSelector:@selector(onMicAudioLevel:)]) {
            [adapter_.delegate onMicAudioLevel:volume];
        }
    }
private:
    PRTCMediaDeviceObjcAdapter *adapter_;
};


@implementation PRTCMediaDeviceObjcAdapter


- (instancetype)initWithAdapter:(id<PRTCRecordingeDelegate>)delegate {
    self = [super init];
    if (self) {
        _audioLevelListener = new PRTCAudioLevelObserve(self);
        _delegate = delegate;
        
    }
    return self;
    
}

@end




@implementation PRTCMediaDeviceObjc
{
    IPRTCMediaDevice *_mediaDevice;
}

static PRTCMediaDeviceObjc * _instance = nil;

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
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mediaDevice = getSharedInstance()->getMediaDevice();
    }
    return self;
}

//- (void)setDelegate:(id<PRTCRecordingeDelegate>)delegate {
//    _delegate = delegate;
//
//
//
//}

+ (void)destory {
    _instance = nil;
    onceToken=0l;
}

///初始化音频模块
///@return 0 succ
- (int)InitAudioMoudle {
    if (_mediaDevice) {
        return _mediaDevice->InitAudioMoudle();
    }
    return PRTCMediaDeviceObjcError;
}

///释放音频模块
///@return 0 succ
- (int)UnInitAudioMoudle {
    if (_mediaDevice) {
        return _mediaDevice->UnInitAudioMoudle();
    }
    return PRTCMediaDeviceObjcError;

}


///初始化视频模块
///@return 0 succ
- (int)InitVideoMoudle {
    if (_mediaDevice) {
        return _mediaDevice->InitVideoMoudle();
    }
    return PRTCMediaDeviceObjcError;

}

///释放视频模块
///@return 0 succ
- (int)UnInitVideoMoudle {
    if (_mediaDevice) {
        return _mediaDevice->UnInitVideoMoudle();
    }
    return PRTCMediaDeviceObjcError;

}

///获取摄像头数目
///@return 数目
- (int)getCamNums {
    if (_mediaDevice) {
        return _mediaDevice->getCamNums();
    }
    return PRTCMediaDeviceObjcError;

}

///获取录音设备数目
///@return 数目
- (int)getRecordDevNums {
    if (_mediaDevice) {
        return _mediaDevice->getRecordDevNums();
    }
    return PRTCMediaDeviceObjcError;

}

///获取播放设备数目
///@return 数目
- (int)getPlayoutDevNums {
    if (_mediaDevice) {
        return _mediaDevice->getPlayoutDevNums();
    }
    return PRTCMediaDeviceObjcError;

}

///获取摄像头信息
///@param index id
///@param  info 设备信息
///@return 0 succ
- (int)getVideoDevInfo:(int)index info:(tPRTCDeviceInfo*) info {
    if (_mediaDevice) {
        return _mediaDevice->getVideoDevInfo(index, info);
    }
    return PRTCMediaDeviceObjcError;

}

///获取录音设备信息
///@param index id
///@param info 设备信息
///@return 0 succ
- (int)getRecordDevInfo:(int)index info:(tPRTCDeviceInfo*)info{
    if (_mediaDevice) {
        return _mediaDevice->getRecordDevInfo(index, info);
    }
    return PRTCMediaDeviceObjcError;

}

///获取播放设备信息
///@param index id
///@param info 设备信息
///@return 0 succ
- (int)getPlayoutDevInfo:(int)index  info:(tPRTCDeviceInfo*)info{
    if (_mediaDevice) {
        return _mediaDevice->getPlayoutDevInfo(index, info);
    }
    return PRTCMediaDeviceObjcError;

}

///获取当前摄像头
///@param info 设备信息
///@return 0 succ
- (int)getCurCamDev:(tPRTCDeviceInfo*)info {
    if (_mediaDevice) {
        return _mediaDevice->getCurCamDev(info);
    }
    return PRTCMediaDeviceObjcError;

}

///获取当前录音设备
///@param info 设备信息
///@return 0 succ
- (int)getCurRecordDev:(tPRTCDeviceInfo* )info {
    if (_mediaDevice) {
        return _mediaDevice->getCurRecordDev(info);
    }
    return PRTCMediaDeviceObjcError;

}

///获取当前播放设备
///@param info 设备信息
///@return 0 succ
- (int)getCurPlayoutDev:(tPRTCDeviceInfo* )info {
    if (_mediaDevice) {
        return _mediaDevice->getCurPlayoutDev(info);

    }
    return PRTCMediaDeviceObjcError;

}

///设置视频设备信息
///@param in info 设备信息
///@return 0 succ
- (int)setVideoDevice:(tPRTCDeviceInfo* )info {
    if (_mediaDevice) {
        return _mediaDevice->setVideoDevice(info);
    }
    return PRTCMediaDeviceObjcError;

}

///设置录制设备信息
///@param in info 设备信息
///@return 0 succ
- (int)setRecordDevice:(tPRTCDeviceInfo* )info {
    if (_mediaDevice) {
        return _mediaDevice->setRecordDevice(info);
    }
    return PRTCMediaDeviceObjcError;

}

///设置播放设备信息
///@param in info 设备信息
///@return 0 succ
- (int)setPlayoutDevice:(tPRTCDeviceInfo* )info {
    if (_mediaDevice) {
        return _mediaDevice->setPlayoutDevice(info);
    }
    return PRTCMediaDeviceObjcError;

}

///获取播放音量
- (int)getPlaybackDeviceVolume:(int *)volume {
    if (_mediaDevice) {
        return _mediaDevice->getPlaybackDeviceVolume(volume);
    }
    return PRTCMediaDeviceObjcError;

}
- (int)setPlaybackDeviceVolume:(int)volume {
    if (_mediaDevice) {
        return _mediaDevice->setPlaybackDeviceVolume(volume);
    }
    return PRTCMediaDeviceObjcError;

}

///获取录制音量
- (int)getRecordingDeviceVolume:(int *)volume {
    if (_mediaDevice) {
        return _mediaDevice->getRecordingDeviceVolume(volume);
    }
    return PRTCMediaDeviceObjcError;

}
- (int)setRecordingDeviceVolume:(int)volume {
    if (_mediaDevice) {
        return _mediaDevice->setRecordingDeviceVolume(volume);
    }
    return PRTCMediaDeviceObjcError;

}

///开启cam测试
///@param  deviceId 设备ID
///@param  profile profile
///@param  hwnd 句柄
///@return 0 succ
- (int)startCamTest:(NSString *)deviceId profile:(ePRTCVideoProfile)profile hwnd:(void*)hwnd {
    if (_mediaDevice) {
        
        return _mediaDevice->startCamTest([deviceId UTF8String], profile, hwnd);
    }
    return PRTCMediaDeviceObjcError;

}

///停止摄像头测试
///@return 0 succ
- (int)stopCamTest {
    if (_mediaDevice) {
        return _mediaDevice->stopCamTest();
    }
    return PRTCMediaDeviceObjcError;
}


///停止录音测试
- (int)stopRecordingDeviceTest {
    if (_mediaDevice) {
        return _mediaDevice->stopRecordingDeviceTest();
    }
    return PRTCMediaDeviceObjcError;
}

///开启播放设备测试
///@param  testAudioFilePath 文件路径
- (int)startPlaybackDeviceTest:(NSString *)testAudioFilePath {
    if (_mediaDevice) {
        return _mediaDevice->startPlaybackDeviceTest([testAudioFilePath UTF8String]);
    }
    return PRTCMediaDeviceObjcError;

}

- (int)startRecordingDeviceTestWithDelegate:(id<PRTCRecordingeDelegate>)delegate {
    // 注册代理
    PRTCMediaDeviceObjcAdapter *adapter = [[PRTCMediaDeviceObjcAdapter alloc] initWithAdapter:delegate];
    if (_mediaDevice) {
        return _mediaDevice->startRecordingDeviceTest(adapter.audioLevelListener);
    }
    return PRTCMediaDeviceObjcError;

}


///停止播放设备测试
- (int)stopPlaybackDeviceTest {
    if (_mediaDevice) {
        return _mediaDevice->stopPlaybackDeviceTest();
    }
    return PRTCMediaDeviceObjcError;
}

///开启摄像头Capture测试
///@param  profile 分辨率
///@param  observer 回调实例
- (int)startCaptureFrame:(ePRTCVideoProfile)profile observer:(IPRTCVideoFrameObserver*)observer {
    if (_mediaDevice) {
        return _mediaDevice->startCaptureFrame(profile, observer);
    }
    return PRTCMediaDeviceObjcError;
}

///停止摄像头Capture测试
- (int)stopCaptureFrame {
    if (_mediaDevice) {
        return _mediaDevice->stopCaptureFrame();
    }
    return PRTCMediaDeviceObjcError;

}

@end
