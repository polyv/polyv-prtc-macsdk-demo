# PRTCSDK_Mac SDK集成指引

通过集成SDK，可以快速实现实时音视频通话。

## 1. 下载资源

  - 可以下载Demo、SDK、API文档  
  
    [现在下载](https://github.com/PRTC/urtc-win-demo.git)  

## 2. 开发语言以及系统要求

  - 开发语言：C++ 、ObjectiveC
  - 系统要求：MacOS 10.15+

## 3. 开发环境

  - XCode
  - 平台 X86_64

## 4. 搭建开发环境

  - 导入 SDK    
  
    将 PRTCSDK_Mac.framework 添加到项目下。


## 5. 实现音视频通话 C++语言集成

### 5.1 初始化

```cpp
Class PRTCEventListenerImpl ： public IPRTCEventListener {
……
};
PRTCEventListener* eventhandler = new PRTCEventListenerImpl

m_rtcengine = getSharedInstance();
m_rtcengine->setChannelTye(PRTC_CHANNEL_TYPE_COMMUNICATION);
//设置房间类型:实时通话、互动直播
m_rtcengine->setSdkMode(PRTC_SDK_MODE_TRIVAL);
//设置测试模式、正式模式
m_rtcengine->setStreamRole(PRTC_USER_STREAM_ROLE_BOTH);
//互动直播模式下，设置用户权限
m_rtcengine->setTokenSecKey(TEST_SECKEY);
//测试模式下设置自己的秘钥
m_rtcengine->setAudioOnlyMode(false);
//设置仅音频模式
m_rtcengine->setAutoPublishSubscribe(false, true);
//设置是否自动订阅
m_rtcengine->configLocalAudioPublish(false)；
//设置是否自动发布
m_rtcengine->configLocalCameraPublish(true);
//设置摄像头是否可以发布
m_rtcengine->configLocalScreenPublish(false);
//设置屏幕是否可以发布
tPRTCVideoConfig& videoconfig
m_rtcengine->setVideoProfile(PRTC_VIDEO_PROFILE_640_360，videoconfig); 
// 设置视频编码参数，PRTC_VIDEO_PROFILE_NONE 时 后面填入自定义编码参数  最大1080p(1920*1080)
```
初始化时，需注意 `setChannelTye`、 `setStreamRole`、参数的设置：   
 - `setChannelTye`用于设置房间类型。一对一或多人通话中，建议设为 `PRTC_CHANNEL_TYPE_COMMUNICATION` ，使用通信场景；互动直播中，建议设为 `PRTC_CHANNEL_TYPE_BROADCAST`，使用直播场景。
 - `setStreamRole`用于设置用户权限。在互动直播中，需要设置主播和连麦方的权限为`PRTC_USER_STREAM_ROLE_BOTH` ，不需要连麦时设置主播为 `PRTC_USER_STREAM_ROLE_PUB` ；观众设置为 `PRTC_USER_STREAM_ROLE_SUB` 。


### 5.2 加入房间

```cpp
tPRTCAuth auth;
auth.mAppId = appid;
auth.mRoomId = roomid;
auth.mUserId = userid;
auth.mUserToken = your generate token;
m_rtcengine->joinChannel(auth);
```

### 5.3 发布流

```cpp
tPRTCMediaConfig config;
config.mAudioEnable = true;
config.mVideoEnable = true;
m_rtcengine->publish(PRTC_MEDIATYPE_VIDEO, config.mVideoEnable,config.mAudioEnable);
```

### 5.4 取消发布

```cpp
tPRTCVideoCanvas view;
view.mVideoView = (int)m_localWnd->GetVideoHwnd();
view.mStreamMtype = PRTC_MEDIATYPE_VIDEO;		
m_rtcengine->stopPreview(view);
m_rtcengine->unPublish(PRTC_MEDIATYPE_VIDEO);
``` 

### 5.5 订阅流
```cpp
m_rtcengine->subscribe(tPRTCStreamInfo & info)
```

### 5.6 取消订阅

```cpp
m_rtcengine->unSubscribe(tPRTCStreamInfo& info)
```


### 5.7 离开房间

```cpp
m_rtcengine->leaveChannel()
```

### 5.8 编译、运行，开始体验吧！

## 6. 实现音视频通话 ObjectiveC语言集成

SDK中已经使用ObjectiveC语言封装了C++的接口，可以直接使用下列的文件。

```
 ├─PRTCSDK_Mac.framework
 | └─Headers
 |   ├─PRTCEngineObjc.h
 |   ├─PRTCEngineObjc.mm
 |   ├─PRTCEngineObjcAdapter.h
 │   ├─PRTCEngineObjcAdapter.mm
 │   ├─PRTCMediaDeviceObjc.h
 └───└─PRTCMediaDeviceObjc.mm
```

### 6.1 初始化

```ObjectiveC
PRTCEngineObjc *prtcEngineObjc = [PRTCEngineObjc sharedWithContext:ctx];
_prtcEngineObjc = prtcEngineObjc;
prtcEngineObjc.delegate = self;
[prtcEngineObjc setSdkMode:PRTC_SDK_MODE_NORMAL];

[prtcEngineObjc setChannelType: _config.channelType == 0 ? PRTC_CHANNEL_TYPE_COMMUNICATION : PRTC_CHANNEL_TYPE_BROADCAST];

[prtcEngineObjc setVideoCodec:(PRTC_CODEC_H264)];
[prtcEngineObjc setStreamRole:PRTC_USER_STREAM_ROLE_BOTH];
[prtcEngineObjc setLogLevel:PRTC_LOG_LEVEL_DEBUG];
[prtcEngineObjc setTokenSecKey:APP_KEY];

[prtcEngineObjc setVideoCodec:PRTC_CODEC_VP8];

[prtcEngineObjc setVideoCaptureProfile:(ePRTCVideoProfile)_config.videoProfle];
tPRTCVideoConfig videoconfig;
[prtcEngineObjc setVideoProfile:(ePRTCVideoProfile)_config.videoProfle config:videoconfig];
[prtcEngineObjc setAutoPublish:_config.autoPublish subscribe:_config.autoSubscribe];
[prtcEngineObjc configLocalScreenPublish:_config.autoPublishScreen];
[prtcEngineObjc configLocalCameraPublish:_config.autoPublishVideo];
[prtcEngineObjc setAudioOnlyMode:_config.isOnlyAudio];
```

### 6.2 加入房间

```ObjectiveC
    tPRTCAuth auth;
    auth.mAppId = [APP_ID UTF8String];
    auth.mRoomId = [_roomId UTF8String];
    auth.mUserId = [_userId UTF8String];
    auth.mUserToken = [token UTF8String];
   
    // 加入房间
    [prtcEngineObjc joinChannel:auth];
```

### 6.3 发布、取消发布和渲染视频流

```ObjectiveC
//发布视频流
[_prtcEngineObjc publish:(PRTC_MEDIATYPE_VIDEO) hasvideo:_config.autoPublishVideo hasaudio:_config.autoPublishAudio];

//取消发布
[_prtcEngineObjc unPublish:PRTC_MEDIATYPE_VIDEO];

//渲染本地屏幕
tPRTCVideoCanvas localCanvas;
localCanvas.mVideoView = (__bridge void*)self.localView;
localCanvas.mUserId = [_userId UTF8String];
localCanvas.mStreamMtype = PRTC_MEDIATYPE_VIDEO;
localCanvas.mRenderMode = PRTC_RENDER_MODE_DEFAULT;
localCanvas.mVideoFrameType = PRTC_VIDEO_FRAME_TYPE_I420;

[prtcEngineObjc startPreview:localCanvas];

//渲染本地屏幕
tPRTCVideoCanvas localScreenCanvas;
localScreenCanvas.mVideoView = (__bridge void*)self.localScreenView;
localScreenCanvas.mUserId = [_userId UTF8String];
localScreenCanvas.mStreamMtype = PRTC_MEDIATYPE_SCREEN;
localScreenCanvas.mRenderMode = PRTC_RENDER_MODE_DEFAULT;
localScreenCanvas.mVideoFrameType = PRTC_VIDEO_FRAME_TYPE_I420;

[_prtcEngineObjc startPreview:localScreenCanvas];

//渲染远程视频流
_renderView = [NSView new];
_renderView.frame = self.view.bounds;
remoteView = _renderView;
tPRTCVideoCanvas canvas;
canvas.mVideoView = (__bridge void*)_remoteView;
canvas.mUserId = [_mUserId UTF8String];
canvas.mStreamId = [_mStreamId UTF8String];
canvas.mStreamMtype = PRTC_MEDIATYPE_VIDEO;
canvas.mRenderMode = PRTC_RENDER_MODE_FIT;
canvas.mVideoFrameType = PRTC_VIDEO_FRAME_TYPE_I420;

[_prtcEngineObjc startRemoteView:canvas];

```

### 6.4 离开房间

```ObjectiveC

[_prtcEngineObjc leaveChannel];
```

### 6.5 编译、运行，开始体验吧！