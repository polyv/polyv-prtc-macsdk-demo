# PRTCSDK Mac API 手册

[一、IPRTCEngine引擎接口 类](#class)
[二、IPRTCMediaDevice设备引擎接口类](#Device)    		
[三、接口错误表](#ErrCode)    
[四、函数结构体说明](#struct)   	

<a name='class'></a>

## 一、 class IPRTCEngine引擎接口类

[1.1  获取引擎 - IPRTCEngine](#class-IPRTCEngine)
[1.2  绑定监听事件 - regRtcEventListener ](#class-regRtcEventListener)
[1.3  设置SDK模式 - setSdkMode](#class-setSdkMode)
[1.4  设置通话模式 - setChannelType](#class-setChannelType)
[1.5  设置流操作权限 - setStreamRole](#class-setStreamRole)
[1.6  设置纯音频模式 - setAudioOnlyMode](#class-setAudioOnlyMode)
[1.7  设置自动发布和订阅 - setAutoPublishSubscribe](#class-setAutoPublishSubscribe)
[1.8  配置本地音频是否发布 - configLocalAudioPublish](#class-configLocalAudioPublish)
[1.9  是否发布音频 - isLocalAudioPublishEnabled](#class-isLocalAudioPublishEnabled)
[1.10  配置是否自动发布本地摄像头 - configLocalCameraPublish](#class-configLocalCameraPublish)
[1.11  是否发布摄像头 - isLocalCameraPublishEnabled](#class-isLocalCameraPublishEnabled)
[1.12  配置是否自动发布本地桌面 - configLocalScreenPublish](#class-configLocalScreenPublish)
[1.13  是否发布桌面 - isLocalScreenPublishEnabled](#class-isLocalScreenPublishEnabled)
[1.14  设置视频编码参数 - setVideoProfile](#class-setVideoProfile)
[1.15  入会时关闭摄像头 - muteCamBeforeJoin](#class-muteCamBeforeJoin)	
[1.16  入会时关闭麦克风 - muteMicBeforeJoin](#class-muteMicBeforeJoin)		
[1.17  加入房间 - joinChannel](#class-joinChannel)
[1.18  离开房间 - leaveChannel](#class-leaveChannel)	
[1.19  发布本地流 - publish](#class-publish)
[1.20  停止发布本地流 - unPublish](#class-unPublish)
[1.21  开启本地渲染 - startPreview](#class-startPreview)	
[1.22  停止本地渲染 - stopPreview](#class-stopPreview)	
[1.23 订阅远端媒体流 - subscribe](#class-subscribe)
[1.24 取消订阅远端媒体流 - unSubscribe](#class-unSubscribe)
[1.25  开启远端渲染 - startRemoteView](#class-startRemoteView)	
[1.26  停止远端渲染 - stopRemoteView](#class-stopRemoteView)	
[1.27  打开/关闭本地麦克风 - muteLocalMic](#class-muteLocalMic)	
[1.28  打开/关闭本地视频 - muteLocalVideo](#class-muteLocalVideo)		
[1.29  应用静音 - enableAllAudioPlay](#class-enableAllAudioPlay)	
[1.30  打开/关闭远端音频 - muteRemoteAudio](#class-muteRemoteAudio)	
[1.31  打开/关闭远端视频 - muteRemoteVideo](#class-muteRemoteVideo)	
[1.32  是否为自动发布模式 - isAutoPublish](#class-isAutoPublish)	
[1.33  是否为自动订阅模式 - isAutoSubscribe](#class-isAutoSubscribe)	
[1.34  切换摄像头 - switchCamera](#class-switchCamera)
[1.35  设置RTSP视频源 - enableExtendRtspVideocapture](#class-enableExtendRtspVideocapture)
[1.36  设置自定义外部视频源 - enableExtendVideocapture](#class-enableExtendVideocapture)	
[1.37  设置音频数据监听 - regAudioFrameCallback](#class-regAudioFrameCallback)	
[1.38  添加micphone混音文件 - startAudioMixing](#class-startAudioMixing)	
[1.39  停止micphone混音 - stopAudioMixing](#class-stopAudioMixing)	
[1.40  设置桌面编码参数 - setDesktopProfile](#class-setDesktopProfile)	
[1.41  设置桌面采集参数 - setCaptureScreenPagrams](#class-setCaptureScreenPagrams)	
[1.42  设置桌面采集类型 - setUseDesktopCapture](#class-setUseDesktopCapture)	
[1.43  获取屏幕个数 - getDesktopNums](#class-getDesktopNums)	
[1.44  获取屏幕信息 - getDesktopInfo](#class-getDesktopInfo)	
[1.45  获取窗口个数 - getWindowNums](#class-getWindowNums)
[1.46  获取窗口信息 - getWindowInfo](#class-getWindowInfo)	
[1.48  开启录制 - startRecord](#class-startRecord)	
[1.49  停止录制 - stopRecord](#class-stopRecord)	
[1.50  设置日志等级 - setLogLevel](#class-setLogLevel)
[1.51  获取SDK 版本 - getSdkVersion](#class-getSdkVersion)	
[1.52  销毁引擎 - destroy](#class-destroy)
[1.53  设置外部音频采集 - enableExtendAudiocapture](#class-enableExtendAudiocapture)
[1.54  注册设备热插拔回调通知 - regDeviceChangeCallback](#class-regDeviceChangeCallback)
[1.55  旁路推流 - addPublishStreamUrl](#class-addPublishStreamUrl)
[1.56  停止旁路推流 - removePublishStreamUrl](#class-removePublishStreamUrl)
[1.57  更新旁路推流合流的流 - updateRtmpMixStream](#class-updateRtmpMixStream)
[1.58  设置接入方式 - setServerGetFrom](#class-setServerGetFrom)
[1.59  推送视频数据 - pushVideoFrameData](#class-pushVideoFrameData)
[1.60  推送音频数据 - pushAudioFrameData](#class-pushAudioFrameData)
[1.61  设置外部源送数据模式 - SetExtendMediaDataMode](#class-SetExtendMediaDataMode)
[1.62  设置音频编码模式 - setAudioProfile](#class-setAudioProfile)
<a name='class-IPRTCEngine'></a>

### 1.1  获取引擎

IPRTCEngine *getSharedInstance()

**返回值**

IPRTCEngine引擎类指针

**参数说明*   

无

**消息回调**

无

<a name='class-regRtcEventListener'></a>

### 1.2  绑定监听事件

void regRtcEventListener(PRTCEventListenerlistener)

**返回值*

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  listener[in]   | PRTCEventListener <br> ePRTCSdkMode     | Class | N |

**消息回调**

无

<a name='class-setSdkMode'></a>

### 1.3  设置SDK模式

virtual int setSdkMode (ePRTCSdkMode mode)

**返回值**

参见错误描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  mode[in]   | 可以设置为测试模式、正式模式，默认不调用为正式模式。 <br> 详见ePRTCSdkMode。     | enum | N |

**消息回调**

无

<a name='class-setChannelType'></a>

###  1.4  设置应用模式

virtual int setChannelType(ePRTCUserStreamRole TYPE)

可以设置为会议模式、直播模式。会议模式，默认都有推流权限；直播模式，可以设置流操作权限：双向、推流、拉流权限，任选其一。

**返回值**

参见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  TYPE[in]   | 可以设置为会议模式、直播模式。 <br> 详见ePRTCUserStreamRole说明。     | enum | N |



<a name='class-setStreamRole'></a>

###  1.5  设置流操作权限

virtual int setStreamRole(ePRTCUserStreamRole role)

**返回值**

参见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  role[in]   | 可以设置为上行推流、下行拉流、双向推拉流。 <br> 详见PRTCStreamRole说明。     | enum | N |


**消息回调**

无

<a name='class-setAudioOnlyMode'></a>

###  1.6  设置纯音频模式

virtual int setAudioOnlyMode(bool audioOnly)

**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  audioOnly[in]  | 是否设置为纯音频模式    | bool | N |

**消息回调**

无

<a name='class-setAutoPublishSubscribe'></a>

###  1.7  设置自动发布和订阅

virtual int setAutoPublishSubscribe(bool autoPub, bool autoSub)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  autoPub[in]  | 是否自动发布流     | bool | N |
|  autoSub[in]   | 是否自动订阅流     | bool | N |

**消息回调**

无


<a name='class-configLocalAudioPublish'></a>

###  1.8  配置是否自动发布本地音频

virtual int configLocalAudioPublish(bool enable)

**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  enable[in]   | 配置自动发布本地音频可选：是、否     | bool | N |

**消息回调**

无


<a name='class-isLocalAudioPublishEnabled'></a>

###  1.9  是否发布音频

virtual bool isLocalAudioPublishEnabled()

是否发布音频，必须在配置自动发布本地音频时，才能调用。

**返回值**

true 发布音频;false 不发布音频。

**参数说明*   

无

**消息回调**

无


<a name='class-configLocalCameraPublish'></a>

###  1.10  配置是否自动发布本地摄像头

virtual int configLocalCameraPublish(bool enable)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  enable[in]   | 配置自动发布本地视频可选：是、否     | bool | N |

**消息回调**

无

<a name='class-isLocalCameraPublishEnabled'></a>

###  1.11  是否发布摄像头

virtual bool isLocalCameraPublishEnabled()

是否发布摄像头，必须在配置自动发布本地摄像头时，才能调用。

**返回值**

true 发布摄像头;false 不发布摄像头。

**参数说明*   

无

**消息回调**

无

<a name='class-configLocalScreenPublish'></a>

###  1.12  配置是否自动发布本地桌面

virtual int configLocalScreenPublish (bool enable)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  enable[in]   | 配置自动发布本地桌面可选：是、否     | bool | N |

**消息回调**

无

<a name='class-isLocalScreenPublishEnabled'></a>

###  1.13  是否发布桌面

virtual bool isLocalScreenPublishEnabled()

是否发布桌面，必须在配置自动发布本地桌面时，才能调用。

**返回值**

true 发布桌面;false 不发布桌面。

**参数说明*   

无

**消息回调**

无


<a name='class-setVideoProfile'></a>

###  1.14  设置视频编码参数

virtual void setVideoProfile(ePRTCVideoProfile& profile，tPRTCVideoConfig& videoconfig)

设置视频编码参数，可选定义好的编码视频分辨率；也可以自定义编码参数，设置视频编码宽、高、帧率。


**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  profile[in]   | 设置视频编码分辨率，详见ePRTCVideoProfile参数说明     | enum | N |
| videoconfig[in]    | 设置视频编码宽、高、帧率 | struct| N |

自定义编码参数时，profile必须为 PRTC_VIDEO_PROFILE_NONE，用户自定义videoconfig参数成员必须指定有效值。

profile为有效值时，后面的参数无意义。

**消息回调**

无

<a name='class-muteCamBeforeJoin'></a>

###  1.15  入会时关闭摄像头

virtual int muteCamBeforeJoin(bool mute)

入会时是否关闭摄像头。如果关闭摄像头，会发送黑屏帧。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  mute[in]   | true，关闭摄像头。 <br> false，打开摄像头。     | bool | N |

**消息回调**

无

<a name='class-muteMicBeforeJoin'></a>

###  1.16  入会时关闭麦克风

virtual int muteMicBeforeJoin (bool mute)

入会时是否关闭麦克风。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  mute[in]   | true，关闭麦克风。 <br> false，打开麦克风。     | bool | N |

**消息回调**

无

<a name='class-joinChannel'></a>

###  1.17  加入房间

virtual int joinChannel(tPRTCAuth & auth)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  auth[in]   | 加入房间参数，包含AppId、RoomId、UserId、Token。<br>详见tPRTCAuth说明。    | struct | N |

**消息回调**

无



<a name='class-leaveChannel'></a>

###  1.18  离开房间

virtual int leaveChannel()

**返回值**

详见错误码描述。

**参数说明*   

无

**消息回调**

code回调为0代表成功，其他代表失败。

具体参见 消息回调事件接口类对应接口virtual void onLeaveRoom(int code, const charmsg, const charuid, const charroomid) {}


<a name='class-publish'></a>

###  1.19  发布本地流

virtual int publish(ePRTCMeidaTypetype, bool hasvideo, bool hasaudio)

发布本地流，支持发布摄像头、发布桌面。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]   | 发布流类型可选:摄像头、桌面。<br> 详见ePRTCMeidaType参数说明。    | enum | N |
|  hasvideo[in]  | 发布流是否带视频    | bool | N |
|  hasaudio[in] | 发布流是否带音频    | bool | N |

**消息回调**

0 成功；其他失败。

具体参见 消息回调事件接口类对应接口virtual void onLocalPublish (const int code, const charmsg, tPRTCStreamInfo& info) {}

<a name='class-unPublish'></a>

###  1.20  停止发布本地流

virtual int unPublish(ePRTCMeidaType type)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]   | 发布流类型可选:摄像头、桌面。<br> 详见ePRTCMeidaType参数说明。    | enum | N |

**消息回调**

0 成功；其他失败。

具体参见 消息回调事件接口类对应接口virtual void onLocalUnPublish (const int code, const charmsg, tPRTCStreamInfo& info) {}

<a name='class-startPreview'></a>

###  1.21  开启本地渲染

virtual int startPreview(tPRTCVideoCanvas& view)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  view[in]  | 包含UserId、StreamId、StreamMtype等。<br> 详见tPRTCVideoCanvas参数说明。    | struct | N |

**消息回调**

无

<a name='class-stopPreview'></a>

###  1.22  停止本地渲染

virtual int stopPreview (tPRTCVideoCanvas& view)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  view[in]  | 包含UserId、StreamId、StreamMtype等。<br> 详见tPRTCVideoCanvas参数说明。    | struct | N |

**消息回调**

无

<a name='class-subscribe'></a>

###  1.23 订阅远端媒体流

virtual int subscribe(tPRTCStreamInfo & info)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]   | 包含UserId、StreamId等。<br> 详见ePRTCMeidaType参数说明。    | enum | N |

**消息回调**

0 成功；其他失败。

具体参见 消息回调事件接口类对应接口virtual void onSubscribeResult(const int code, const charmsg, tPRTCStreamInfo& info) {}

<a name='class-unSubscribe'></a>

###  1.24 取消订阅远端媒体流

virtual void unSubscribe(tPRTCStreamInfo& info)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]   | 包含UserId、StreamId等。<br> 详见ePRTCMeidaType参数说明。    | enum | N |

**消息回调**

0 成功；其他失败。

具体参见 消息回调事件接口类对应接口virtual void onUnSubscribeResult(const int code, const charmsg, tPRTCStreamInfo& info) {}

<a name='class-startRemoteView'></a>

###  1.25  开启远端渲染

virtual int startRemoteView (tPRTCVideoCanvas & view)

开启远端渲染,必须在订阅成功后才能调用。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  view[in]  | 包含UserId、StreamId、StreamMtype等。<br> 详见tPRTCVideoCanvas参数说明。    | struct | N |

**消息回调**

无

<a name='class-stopRemoteView'></a>

###  1.26  停止远端渲染

virtual int stopRemoteView (tPRTCVideoCanvas & view)

停止远端渲染,必须在订阅成功后才能调用。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  view[in]  | 包含UserId、StreamId、StreamMtype等。<br> 详见tPRTCVideoCanvas参数说明。    | struct | N |

**消息回调**

无


<a name='class-muteLocalMic'></a>

###  1.27  打开/关闭本地麦克风

virtual int muteLocalMic(bool mute)

是否关闭本地麦克风。关闭后发送静音包。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  mute[in]   | 是否关闭本地麦克风     | bool | N |

**消息回调**

0 成功；其他失败。

具体参见 消息回调事件接口类对应接口virtual void onLocalStreamMuteRsp(const int code, const charmsg, ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {}


<a name='class-muteLocalVideo'></a>

###  1.28  打开/关闭本地视频

virtual int muteLocalVideo(bool mute, ePRTCMeidaType mtype)

是否关闭本地视频。关闭后，发送黑屏帧。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  mute[in]   | 是否关闭本地视频     | bool | N |
|  mtype[in]  | 流类型可选:摄像头、桌面。<br> 详见ePRTCMeidaType参数说明。      | enum | N |

**消息回调**

无


<a name='class-enableAllAudioPlay'></a>

###  1.29  应用静音

virtual int enableAllAudioPlay(bool enable)

关闭应用的声音，静音。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  enable[in]  | true，打开声音播放。 <br> false，关闭应用声音。     | bool | N |

**消息回调**

无


<a name='class-muteRemoteAudio'></a>

###  1.30  打开/关闭远端音频

virtual int muteRemoteAudio (tPRTCStreamInfo& info,bool mute)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]   | 包含UserId、StreamId等。<br> 详见tPRTCStreamInfo参数说明。    | enum | N |
|  mute[in]   | true，关闭远端音频。 <br> false，打开远端音频。     | bool | N |

**消息回调**

code回调为0代表成功，其他代表失败。

具体参见 消息回调事件接口类对应接口virtual void onRemoteStreamMuteRsp(const int code, const charmsg, const charuid, ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {}


<a name='class-muteRemoteVideo'></a>

###  1.31  打开/关闭远端视频

virtual int muteRemoteVideo(tPRTCStreamInfo& info, bool mute)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]   | 包含UserId、StreamId等。<br> 详见tPRTCStreamInfo参数说明。    | enum | N |
|  mute[in]   | true，关闭远端视频。 <br> false，打开远端视频。     | bool | N |

**消息回调**

code回调为0代表成功，其他代表失败。

具体参见 消息回调事件接口类对应接口virtual void onRemoteStreamMuteRsp(const int code, const charmsg, const charuid, ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {}


<a name='class-isAutoPublish'></a>

###  1.32  是否为自动发布模式

virtual bool isAutoPublish()

**返回值**

true 是，false 不是。

**参数说明*   

无

**消息回调**

无


<a name='class-isAutoSubscribe'></a>

###  1.33  是否为自动订阅模式

virtual bool isAutoSubscribe()

**返回值**

true 是，false 不是。

**参数说明*   

无

**消息回调**

无


<a name='class-switchCamera'></a>

###  1.34  切换摄像头

virtual int switchCamera(tPRTCDeviceInfo& info)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  info[in]  | 切换的摄像头设备信息    | tPRTCDeviceInfo| N |

**消息回调**

无

<a name='class-enableExtendRtspVideocapture'></a>

###  1.35  设置RTSP视频源

virtual int enableExtendRtspVideocapture(ePRTCMeidaType type, bool enable, const charrtspurl)

设置RTSP视频源，支持设置2路RTSP视频源。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  type[in]  | rtsp要替换的视频源     | ePRTCMeidaType| N |
|  enable[in]  | 是否开启RTSP源输入     | bool | N |
|  rtspurl[in]  | rtsp 地址     | char| N |

**消息回调**

无

<a name='class-enableExtendVideocapture'></a>

###  1.36  设置自定义外部视频源

virtual int enableExtendVideocapture(bool enable, PRTCExtendVideoCaptureSourcevideocapture)

设置自定义外部视频源。

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  enable[in] | 是否开启自定义外部视频源输入     | bool| N |
|  Videocapture[in]  | 自定义外部数据源     | PRTCExtendVideoCaptureSource | N |

**消息回调**

无

<a name='class-regAudioFrameCallback'></a>

###  1.37  设置音频数据监听

virtual void regAudioFrameCallback(PRTCAudioFrameCallbackcallback)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  callback[in]  | 音频回调监听     | PRTCAudioFrameCallback | N |

**消息回调**

无


<a name='class-startAudioMixing'></a>

###  1.38  添加micphone混音文件

virtual int startAudioMixing(const charfilepath, bool replace, bool loop,float musicvol)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  filepath [in]   | 文件地址     | const char*| N |
|  replace[in]     | 是否取代mic 输入:true 替代、false 混合     | bool| N |
|  loop[in]  | 是否循环播放：true 循环播放、false 一次播放    | bool| N |
|  musicvol[in]   | 背景音音量（0.0 – 1.0），1.0表示原始音量    | float| N |

**消息回调**

无

<a name='class-stopAudioMixing'></a>

###  1.39  停止micphone混音

virtual int stopAudioMixing()

**返回值**

详见错误码描述。

**参数说明*   

无

**消息回调**

无




<a name='class-setDesktopProfile'></a>

###  1.40  设置桌面编码参数

virtual void setDesktopProfile (ePRTCVideoProfile& profile)

设置桌面编码参数，可以设定桌面或者某一窗口的编码分辨率。

**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  profile[in]   | 设置视频编码分辨率，详见ePRTCVideoProfile参数说明     | enum | N |

**消息回调**

无

<a name='class-setCaptureScreenPagrams'></a>

###  1.41  设置桌面采集参数

virtual void setCaptureScreenPagrams (tPRTCScreenPargram& par)

**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  par[in]   | 设置包含窗口或者桌面id标识、起始坐标、宽、高。<br> 详见tPRTCScreenPargram参数说明。     | struct | N |

**消息回调**

无

<a name='class-setUseDesktopCapture'></a>

###  1.42  设置桌面采集类型

virtual int setUseDesktopCapture(ePRTCDesktopType desktoptype)

**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  desktoptype [in]  | 可选采集的是桌面还是窗口。<br> 详见ePRTCDesktopType参数说明。     | enum | N |

**消息回调**

无

<a name='class-getDesktopNums'></a>

###  1.43  获取屏幕个数

virtual void getDesktopNums ()

**返回值**

屏幕个数。

**参数说明*   

无

**消息回调**

无

<a name='class-getDesktopInfo'></a>

###  1.44  获取屏幕信息

virtual int getDesktopInfo(int pos, tPRTCDeskTopInfo& info)

**返回值**

0 成功；其他失败。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  pos[in]   | 数组下标，个数通过getDesktopNums 获取     | int | N |
| info[in]    | 包含桌面/窗口类型、id 标识、桌面标题。<br> 详见tPRTCDeskTopInfo参数说明。  | struct| N |

**消息回调**

无

<a name='class-getWindowNums'></a>

###  1.45  获取窗口个数

virtual void getWindowNums ()

**返回值**

窗口个数。

**参数说明*   

无

**消息回调**

无

<a name='class-getWindowInfo'></a>

###  1.46  获取窗口信息

virtual int getWindowInfo (int pos, tPRTCDeskTopInfo& info)

**返回值**

0 成功；其他失败。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  pos[in]   | 数组下标，个数通过getWindowNums 获取     | int | N |
| info[in]    | 包含桌面/窗口类型、id 标识、桌面标题。<br> 详见tPRTCDeskTopInfo参数说明。  | struct| N |

**消息回调**

无


<a name='class-startRecord'></a>

###  1.48  开启录制

virtual int startRecord(tPRTCRecordConfig& recordconfig)

**返回值**

详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  recordconfig [in]  | 录制参数，具体详见tPRTCRecordConfig。     | struct | N |

**消息回调**

code回调为0代表成功，其他代表失败。

具体参见 消息回调事件接口类对应接口virtual void onStartRecord(const int code, const charmsg, tPRTCRecordInfo& info) {} 



<a name='class-stopRecord'></a>

###  1.49  停止录制

virtual int stopRecord ()

**返回值**

详见错误码描述。

**参数说明*   

无

**消息回调**

code回调为0代表成功，其他代表失败。

具体参见 消息回调事件接口类对应接口virtual void onStopRecord(const int code, const charmsg, const charrecordid) {} 


<a name='class-setLogLevel'></a>

###  1.50  设置日志等级

virtual void setLogLevel(ePRTCLogLevel level)

**返回值**

无

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  level[in]   | 可以设置为DEBUG、消息、告警、错误、无告警。 <br> 详见ePRTCLogLevel说明。     | enum | N |

**消息回调**

无


<a name='class-getSdkVersion'></a>

### 1.51  获取SDK 版本

const char *getSdkVersion()

**返回值**

SDK的版本号

**参数说明*   

无

**消息回调**

无

<a name='class-destroy'></a>

### 1.52  销毁引擎

void destroySharedInstance()

**返回值**

无

**参数说明*   

无

**消息回调**

无

<a name='class-enableExtendAudiocapture'></a>

### 1.53  开启外部音频采集

int enableExtendAudiocapture(bool enable, PRTCExtendAudioCaptureSourceaudiocapture)

**返回值**

0 代表成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  enable[in]   | 设置true还是false     | bool | N |
| audiocapture[in]    | 外部音频源。<br> 详见PRTCExtendAudioCaptureSource参数说明。  | struct| N |

**消息回调**

无

<a name='class-regDeviceChangeCallback'></a>

### 1.54  注册设备热插拔回调通知

virtual void regDeviceChangeCallback(PRTCDeviceChangedcallback)

**返回值**

无

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| callback[in]    | 回调通知句柄<br> 详见PRTCDeviceChanged参数说明。  | struct| N |

**消息回调**

无

<a name='class-addPublishStreamUrl'></a>

### 1.55  旁路推流

virtual int addPublishStreamUrl(const charurl, tPRTCTranscodeConfig *config)

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| url[in]    | cdn地址<br>   | string| N |
| config[in]    | 转推配置<br> 详见tPRTCTranscodeConfig参数说明。  | struct| N |
**消息回调**

void onRtmpStreamingStateChanged(const int 	state, const charurl, int code)

<a name='class-removePublishStreamUrl'></a>

### 1.56  停止旁路推流

virtual int removePublishStreamUrl(const charurl)

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| url[in]    | cdn地址<br>   | string| N |

**消息回调**

void onRtmpStreamingStateChanged(const int 	state, const charurl, int code)

<a name='class-updateRtmpMixStream'></a>

### 1.57  更新旁路推流合流的流

virtual int updateRtmpMixStream(ePRTCRtmpOpration cmd, tPRTCRelayStreamstreams,int length)

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| cmd[in]    | 操作类型<br> 详见ePRTCRtmpOpration参数说明。  | int| N |
| streams[in]    | 流列表<br> 详见tPRTCRelayStream参数说明。  | struct| N |
| length[in]    | 流长度<br>   | int| N |

**消息回调**

virtual void onRtmpUpdateMixStreamRes(ePRTCRtmpOpration& cmd,const int code, const charmsg)

<a name='class-setServerGetFrom'></a>

### 1.58  设置接入方式

virtual int setServerGetFrom(ePRTCServerGetFrom from) = 0;

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| from[in]    | 接入类型<br> 详见ePRTCServerGetFrom参数说明。  | int| N |

<a name='class-pushVideoFrameData'></a>

### 1.59  推送视频数据

virtual int pushVideoFrameData(tPRTCVideoFrame *video) = 0;

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| video[in]    | 接入类型<br> 详见tPRTCVideoFrame参数说明。  | int| N |

<a name='class-pushAudioFrameData'></a>

### 1.60  推送音频数据

virtual int pushAudioFrameData(tPRTCAudioFrame *audio) = 0;

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| audio[in]    | 接入类型<br> 详见tPRTCAudioFrame参数说明。  | int| N |

<a name='class-SetExtendMediaDataMode'></a>

### 1.61  设置外部源送数据模式

virtual int SetExtendMediaDataMode(ePRTCExtendMediaDataMode mode) = 0;

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| mode[in]    | 接入类型<br> 详见ePRTCExtendMediaDataMode参数说明。  | int| N |

<a name='class-setAudioProfile'></a>

### 1.62  setAudioProfile

virtual int setAudioProfile(ePRTCAudioProfile audio_profile) = 0;

**返回值**

0 成功

**参数说明*   


| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
| audio_profile[in]    | 接入类型<br> 详见ePRTCAudioProfile参数说明。  | int| N |




<a name='Device'></a>

## 二、PRTCMediaDevice设备引擎接口类
[2.1  初始化设备模块 - PRTCMediaDevice](#Device-PRTCMediaDevice)		
[2.2  销毁设备模块 - destory](#Device-destory)			
[2.3  初始化视频模块 - InitVideoMoudle](#Device-InitVideoMoudle)		
[2.4  销毁视频模块 - UnInitVideoMoudle](#Device-UnInitVideoMoudle)		
[2.5  初始化音频模块 - InitAudioMoudle](#Device-InitAudioMoudle)		
[2.6  销毁音频模块 - UnInitAudioMoudle](#Device-UnInitAudioMoudle)			
[2.7  获取摄像头数量 - getCamNums](#Device-getCamNums)		
[2.8  获取麦克风数量 - getRecordDevNums](#Device-getRecordDevNums)			
[2.9  获取播放设备数量 - getPlayoutDevNums](#Device-getPlayoutDevNums)		
[2.10  获取摄像头设备信息 - getVideoDevInfo](#Device-getVideoDevInfo)			
[2.11  获取麦克风设备信息 - getRecordDevInfo](#Device-getRecordDevInfo)		
[2.12  获取播放设备信息 - getPlayoutDevInfo](#Device-getPlayoutDevInfo)		
[2.13  获取当前使用的摄像头信息 - getCurCamDev](#Device-getCurCamDev)		
[2.14  获取当前使用的麦克风设备信息 - getCurRecordDev](#Device-getCurRecordDev)		
[2.15  获取当前使用的播放设备信息 - getCurPlayoutDev](#Device-getCurPlayoutDev)		
[2.16  设置视频设备 - setVideoDevice](#Device-setVideoDevice)		
[2.17  设置麦克风设备 - setRecordDevice](#Device-setRecordDevice)			
[2.18  设置播放设备 - setPlayoutDevice](#Device-setPlayoutDevice)		
[2.19  获取应用播放音量 - getPlaybackDeviceVolume](#Device-getPlaybackDeviceVolume)			
[2.20  设置应用播放音量 - setPlaybackDeviceVolume](#Device-setPlaybackDeviceVolume)		
[2.21  获取系统麦克风音量 - getRecordingDeviceVolume](#Device-getRecordingDeviceVolume)			
[2.22  设置系统麦克风音量 - setRecordingDeviceVolume](#Device-setRecordingDeviceVolume)		
[2.23  开始摄像头测试 - startCamTest](#Device-startCamTest)		
[2.24  停止摄像头测试 - stopCamTest](#Device-stopCamTest)			
[2.25  开始麦克风测试 - startRecordingDeviceTest](#Device-startRecordingDeviceTest)		
[2.26  停止麦克风测试 - stopRecordingDeviceTest](#Device-stopRecordingDeviceTest)		
[2.27  开始播放设备测试 - startPlaybackDeviceTest](#Device-startPlaybackDeviceTest)		
[2.28  停止播放设备测试 - stopPlaybackDeviceTest](#Device-stopPlaybackDeviceTest)			
[2.29  开始采集视频数据回调 - startCaptureFrame](#Device-startCaptureFrame)		
[2.30  停止采集视频数据回调 - stopCaptureFrame](#Device-stopCaptureFrame)	


<a name='Device-PRTCMediaDevice'></a>

###  2.1  初始化设备模块

static PRTCMediaDevice*sharedInstance()

**返回值**

PRTCMediaDevice 设备类指针

**参数说明*   

无

**消息回调**

无

<a name='Device-destory'></a>

###  2.2  销毁设备模块

static void destory()

**返回值**

无

**参数说明*   

无

**消息回调**

无

<a name='Device-InitVideoMoudle'></a>

###  2.3  初始化视频模块

virtual int InitVideoMoudle()

**返回值**

code回调为0代表成功，其他代表失败。

**参数说明*   

无

**消息回调**

无

<a name='Device-UnInitVideoMoudle'></a>

###  2.4  销毁视频模块

virtual int UnInitVideoMoudle()

**返回值**

0 成功，其他失败。

**参数说明*   

无

**消息回调**

无

<a name='Device-InitAudioMoudle'></a>

###  2.5  初始化音频模块

virtual int InitAudioMoudle ()

**返回值**

code回调为0代表成功，其他代表失败。

**参数说明*   

无

**消息回调**

无


<a name='Device-UnInitAudioMoudle'></a>

###  2.6  销毁音频模块

virtual int UnInitAudioMoudle()

**返回值**

code回调为0代表成功，其他代表失败。

**参数说明*   

无

**消息回调**

无

<a name='Device-getCamNums'></a>

###  2.7  获取摄像头数量

virtual int getCamNums()

**返回值**

摄像头的数量。

**参数说明*   

无

**消息回调**

无

<a name='Device-getRecordDevNums'></a>

###  2.8  获取麦克风数量

virtual int getRecordDevNums()

**返回值**

获取的麦克风数量。

**参数说明*   

无

**消息回调**

无

<a name='Device-getPlayoutDevNums'></a>

###  2.9  获取播放设备数量

virtual int getPlayoutDevNums()

**返回值**

获取的播放设备数量。

**参数说明*   

无

**消息回调**

无

<a name='Device-getVideoDevInfo'></a>

###  2.10  获取摄像头设备信息

virtual int getVideoDevInfo(int index, char devname[MAX_DEVICE_NAME_LEN], char devid[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  index[in]  | 对应的数组下标     | int | N |
|  devname[in] | 设备名称     | char数组 | N |
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无

<a name='Device-getRecordDevInfo'></a>

###  2.11  获取麦克风设备信息

virtual int getRecordDevInfo(int index, char devname[MAX_DEVICE_NAME_LEN], char devid[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  index[in]  | 对应的数组下标     | int | N |
|  devname[in] | 设备名称     | char数组 | N |
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无


<a name='Device-getPlayoutDevInfo'></a>

###  2.12  获取播放设备信息

virtual int getPlayoutDevInfo(int index, char devname[MAX_DEVICE_NAME_LEN], char devid[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  index[in]  | 对应的数组下标     | int | N |
|  devname[in] | 设备名称     | char数组 | N |
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无

<a name='Device-getCurCamDev'></a>

###  2.13  获取当前使用的摄像头信息

virtual int getCurCamDev (char devname[MAX_DEVICE_NAME_LEN], char devid[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  devname[in] | 设备名称     | char数组 | N |
|  devid[in]  | 设备id 号     | char数组 | N |


**消息回调**

无


<a name='Device-getCurRecordDev'></a>

###  2.14  获取当前使用的麦克风设备信息

virtual int getCurRecordDev (char devname[MAX_DEVICE_NAME_LEN], char devid[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  devname[in] | 设备名称     | char数组 | N |
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无


<a name='Device-getCurPlayoutDev'></a>

###  2.15  获取当前使用的播放设备信息

virtual int getCurPlayoutDev (char devname[MAX_DEVICE_NAME_LEN], char devid[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  devname[in] | 设备名称     | char数组 | N |
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无

<a name='Device-setVideoDevice'></a>

###  2.16  设置视频设备

virtual int setVideoDevice(const char deviceId[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无


<a name='Device-setRecordDevice'></a>

###  2.17  设置麦克风设备

virtual int setRecordDevice(const char deviceId[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无

<a name='Device-setPlayoutDevice'></a>

###  2.18  设置播放设备

virtual int setPlayoutDevice (const char deviceId[MAX_DEVICE_NAME_LEN])

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  devid[in]  | 设备id 号     | char数组 | N |

**消息回调**

无

<a name='Device-getPlaybackDeviceVolume'></a>

###  2.19  获取应用播放音量

virtual int getPlaybackDeviceVolume (int *volume)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  volume[out] | 系统播放音量（0-255）     | int 指针 | N |

**消息回调**

无

<a name='Device-setPlaybackDeviceVolume'></a>

###  2.20  设置应用播放音量

virtual int setPlaybackDeviceVolume (int volume)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  volume[out] | 系统播放音量（0-255）     | int 指针 | N |

**消息回调**

无

<a name='Device-getRecordingDeviceVolume'></a>

###  2.21  获取系统麦克风音量

virtual int getRecordingDeviceVolume (int *volume)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  volume[out] | 系统麦克风音量（0-255）  | int 指针 | N |

**消息回调**

无

<a name='Device-setRecordingDeviceVolume'></a>

###  2.22  设置系统麦克风音量

virtual int setRecordingDeviceVolume (int volume)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  volume[out] | 系统麦克风音量（0-255）  | int 指针 | N |

**消息回调**

无

<a name='Device-startCamTest'></a>

###  2.23  开始摄像头测试

virtual int startCamTest(const char deviceId[MAX_DEVICE_NAME_LEN]，PRTCVideoProfile& profile , voidvideoview)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  deviceid[in]  | 摄像头的id     | char 数组 | N |
|  profile[in] | 摄像头的参数     | PRTCVideoProfile | N |
|  videoview[in] | 显示的渲染窗口句柄    | char 数组 | N |

**消息回调**

无

<a name='Device-stopCamTest'></a>

###  2.24  停止摄像头测试

virtual int stopCamTest()

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

无

**消息回调**

无

<a name='Device-startRecordingDeviceTest'></a>

###  2.25  开始麦克风测试

virtual int startRecordingDeviceTest(PRTCAudioLevelListeneraudiolevel)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  volume[out] | 音频能量回调  | PRTCAudioLevelListener| N |

**消息回调**

virtual void onMiceAudioLevel(int volume) {} volume 音频能量 （0--255）


<a name='Device-stopRecordingDeviceTest'></a>

###  2.26  停止麦克风测试

virtual int stopRecordingDeviceTest()

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

无

**消息回调**

无

<a name='Device-startPlaybackDeviceTest'></a>

###  2.27  开始播放设备测试

virtual int startPlaybackDeviceTest(const charfilePath)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  filePath[in]  | 播放文件的地址（wav 格式）     | const char| N |

**消息回调**

无

<a name='Device-stopPlaybackDeviceTest'></a>

###  2.28  停止播放设备测试

virtual int stopPlaybackDeviceTest()

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

无

**消息回调**

无

<a name='Device-startCaptureFrame'></a>

###  2.29  开始采集视频数据回调

virtual int startCaptureFrame(ePRTCVideoProfile profile,PRTCVideoFrameObserverobserver)

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

| 名称    | 说明 | 数据类型 | 可空 |
| -| -| -| -|
|  profile[in]  | 采集的视频参数     | ePRTCVideoProfile | N |
|  observer[in]  | 视频数据监听类     | PRTCVideoFrameObserver | N |

**消息回调**

无

<a name='Device-stopCaptureFrame'></a>

###  2.30  停止采集视频数据回调

virtual int stopCaptureFrame()

**返回值**

code回调为0代表成功，其他代表失败。详见错误码描述。

**参数说明*   

无

**消息回调**

无

<a name='ErrCode'></a>

## 三、 接口错误表
[3.1  事件回调错误码](#ErrCode-shijian)		
[3.2  函数值错误码](#ErrCode-hanshu)	


<a name='ErrCode-shijian'></a>

###  3.1  事件回调错误码

```cpp
typedef enum _tPRTCCallbackErrCode{    
	PRTC_CALLBACK_ERR_CODE_OK = 0,  //成功    
	PRTC_CALLBACK_ERR_SERVER_CON_FAIL = 5000, //服务器连接失败    
	PRTC_CALLBACK_ERR_SERVER_DIS, // 服务端连接断开    
	PRTC_CALLBACK_ERR_SAME_CMD,  //重复的调用    
	PRTC_CALLBACK_ERR_NOT_IN_ROOM, //未加入房间 无发进行操作     
	PRTC_CALLBACK_ERR_ROOM_JOINED, // 已加入房间 无需加入    
	PRTC_CALLBACK_ERR_SDK_INNER,   // SDK 内部错误    
	PRTC_CALLBACK_ERR_ROOM_RECONNECTING, // 重连中 请求无法投递          
	PRTC_CALLBACK_ERR_STREAM_PUBED,  // 流已经发布  无需发布    
	PRTC_CALLBACK_ERR_PUB_NO_DEV,  // 发布无可用 音频 视频设备    
	PRTC_CALLBACK_ERR_STREAM_NOT_PUB, //流没有发布 无法对流进行操作    
	PRTC_CALLBACK_ERR_STREAM_SUBED,  //流已经订阅  无需订阅    
	PRTC_CALLBACK_ERR_STREAM_NO_SUB, //流没有订阅  无法    
	PRTC_CALLBACK_ERR_SUB_NO_USER,   //无对应的用户 无法订阅    
	PRTC_CALLBACK_ERR_SUB_NO_STREAM,  // 无对应的媒体流    
	PRTC_CALLBACK_ERR_USER_LEAVING, // 用户正在离开房间  无法进行其他操作    
	PRTC_CALLBACK_ERR_NO_HAS_TRACK,  //无对应的媒体轨道    
	PRTC_CALLBACK_ERR_MSG_TIMEOUT, // 消息请求超时    
}tPRTCCallbackErrCode;    
```

<a name='ErrCode-hanshu'></a>

###  3.2  函数值错误码

```cpp
typedef enum _tPRTCReturnErrCode {    
	PRTC_RETURN_ERR_CODE_OK = 0,  //成功    
	PRTC_RETURN_ERR_AUTO_PUB = 1000, //自动发布    
	PRTC_RETURN_ERR_AUTO_SUB, //自动订阅    
	PRTC_RETURN_ERR_NOT_INIT, //引擎没有初始化    
	PRTC_RETURN_ERR_IN_ROOM, //已经加入房间    
	PRTC_RETURN_ERR_NOT_IN_ROOM, // 未加入房间    
	PRTC_RETURN_ERR_NOT_PUB_TRACK, //未发布对应媒体    
	PRTC_RETURN_ERR_INVAILED_PARGRAM, // 无效参数    
	PRTC_RETURN_ERR_INVAILED_WND_HANDLE, // 无效窗口句柄    
	PRTC_RETURN_ERR_INVAILED_MEDIA_TYPE, // 无效媒体类型    
	PRTC_RETURN_ERR_SUB_ONEMORE, // 最少订阅一种媒体    
	PRTC_RETURN_ERR_NO_PUB_ROLE, //无发布权限    
	PRTC_RETURN_ERR_NO_SUB_ROLE, //无订阅权限    
	PRTC_RETURN_ERR_CAM_NOT_ENABLE, //没有配置本地cam 发送    
	PRTC_RETURN_ERR_SCREEN_NOT_ENABLE, //没有配置本地screen 发送    
	PRTC_RETURN_ERR_AUDIO_MODE,        // 纯音频模式    
	PRTC_RETURN_ERR_SECKEY_INVALID ,    // seckey 无效    
	PRTC_RETURN_ERR_INVAILD_FILEPATH,    
	PRTC_RETURN_ERR_NOT_SUPORT_AUDIO_FORMAT,    
}tPRTCReturnErrCode;    
```

<a name='struct'></a>

## 四、 函数结构体说明
[4.1  设备信息类 - tPRTCDeviceInfo](#struct-tPRTCDeviceInfo)		
[4.2  媒体发布配置类 - tPRTCMediaConfig](#struct-tPRTCMediaConfig)		
[4.3  媒体轨道类型类型描述 - ePRTCTrackType](#struct-ePRTCTrackType)		
[4.4  媒体流类型描述 - ePRTCMeidaType](#struct-ePRTCMeidaType)		
[4.5  流信息结构体 - tPRTCStreamInfo](#struct-tPRTCStreamInfo)		
[4.6  录制水印位置 - ePRTCWaterMarkPos](#struct-ePRTCWaterMarkPos)		
[4.7  水印类型 - ePRTCWaterMarkType](#struct-ePRTCWaterMarkType)		
[4.8  Mute操作结构体 - tPRTCMuteSt](#struct-tPRTCMuteSt)		
[4.9  录制输出等级 - ePRTCRecordProfile](#struct-ePRTCRecordProfile)		
[4.10  录制媒体类型 - ePRTCRecordType](#struct-ePRTCRecordType)			
[4.11  录制配置信息 - tPRTCRecordConfig](#struct-tPRTCRecordConfig)		
[4.12  渲染模式 - ePRTCRenderMode](#struct-ePRTCRenderMode)		
[4.13  日志级别 - ePRTCLogLevel](#struct-ePRTCLogLevel)		
[4.14  视频质量参数 - ePRTCVideoProfile](#struct-ePRTCVideoProfile)		
[4.15  桌面输出参数 - ePRTCScreenProfile](#struct-ePRTCScreenProfile)		
[4.16  桌面采集参数 - tPRTCScreenPargram](#struct-tPRTCScreenPargram)		
[4.17  桌面采集类型 - ePRTCDesktopType](#struct-ePRTCDesktopType)		
[4.18  桌面参数 - tPRTCDeskTopInfo](#struct-tPRTCDeskTopInfo)		
[4.19  通道类型 - ePRTCUserStreamRoleCHANNEL](#struct-ePRTCUserStreamRoleCHANNEL)		
[4.20  流权限 - ePRTCUserStreamRoleSTREAM](#struct-ePRTCUserStreamRoleSTREAM)	
[4.21  渲染窗口 - tPRTCVideoCanvas](#struct-tPRTCVideoCanvas)		
[4.22  登录信息类 - tPRTCAuth](#struct-tPRTCAuth)		
[4.23  当前媒体状态统计 - tPRTCStreamStats](#struct-tPRTCStreamStats)		
[4.24  录制信息回调 - tPRTCRecordInfo](#struct-tPRTCRecordInfo)		
[4.25  音频帧 - tPRTCAudioFrame](#struct-tPRTCAudioFrame)		
[4.26  视频数据帧类型 - ePRTCVideoFrameType](#struct-ePRTCVideoFrameType)		
[4.27  视频数据帧 - tPRTCVideoFrame](#struct-tPRTCVideoFrame)		
[4.28  消息回调事件接口类 - PRTCEventListener](#struct-PRTCEventListener)		
[4.29  音频测试回调 - PRTCMediaListener](#struct-PRTCMediaListener)		
[4.30  音频数据回调 - PRTCAudioFrameCallback](#struct-PRTCAudioFrameCallback)			
[4.31  视频扩展数据源 - PRTCExtendVideoCaptureSource](#struct-PRTCExtendVideoCaptureSource)		
[4.32  视频数据回调 - PRTCExtendVideoRender](#struct-PRTCExtendVideoRender)		
[4.33  视频数据回调监听类（yuv420p格式） - PRTCVideoFrameObserver](#struct-PRTCVideoFrameObserver)		
[4.34  视频渲染类型 - ePRTCRenderType](#struct-ePRTCRenderType)		
[4.35  视频编码类型 - ePRTCVideoCodec](#struct-ePRTCVideoCodec)		
[4.36  视频参数 - tPRTCVideoConfig](#struct-tPRTCVideoConfig)	
[4.37  上下行网络类型 - ePRTCNetworkQuality](#struct-ePRTCNetworkQuality)
[4.38  网络评分 - ePRTCQualityType](#struct-ePRTCQualityType)
[4.39  热插拔回调 - PRTCDeviceChanged](#struct-PRTCDeviceChanged)
[4.40 音频外部采集 - PRTCExtendAudioCaptureSource](#struct-PRTCExtendAudioCaptureSource)
[4.41  转推的流 - PRTCRelayStream](#struct-PRTCRelayStream)
[4.42  转推混流操作类型 - ePRTCMixLayout](#struct-ePRTCMixLayout)
[4.43  转推配置 - PRTCTranscodeConfig](#struct-PRTCTranscodeConfig)
[4.44  外部源模式 - ePRTCExtendMediaDataMode](#struct-ePRTCExtendMediaDataMode)
[4.45  音频编码属性 - ePRTCAudioProfile](#struct-ePRTCAudioProfile)

<a name='struct-tPRTCDeviceInfo'></a>

###  4.1  设备信息类

```cpp
typedef struct {    
	char mDeviceName[MAX_DEVICE_ID_LENGTH]; // 设备名称    
	char mDeviceId[MAX_DEVICE_ID_LENGTH];   // 设备id    
} tPRTCDeviceInfo;    
```

<a name='struct-tPRTCMediaConfig'></a>

###  4.2  媒体发布配置类

最少启用一种媒体
    
```cpp
typedef struct {    
	bool mVideoEnable; // 启用视频    
	bool mAudioEnable; // 启用音频    
}tPRTCMediaConfig;    
```

<a name='struct-ePRTCTrackType'></a>

###  4.3  媒体轨道类型类型描述

```cpp
typedef enum {    
	PRTC_TRACKTYPE_AUDIO = 1, // 音频轨道    
	PRTC_TRACKTYPE_VIDEO   // 视频轨道    
} ePRTCTrackType;    
```
<a name='struct-ePRTCMeidaType'></a>

###  4.4  媒体流类型描述

```cpp
typedef enum {    
   	PRTC_MEDIATYPE_NONE = 0, // 无效类型    
	PRTC_MEDIATYPE_VIDEO, // 摄像头    
	PRTC_MEDIATYPE_SCREEN  // 桌面流    
} ePRTCMeidaType;    
```

<a name='struct-tPRTCStreamInfo'></a>

###  4.5  流信息结构体

```cpp
typedef struct {    
	const charmUserId;  // 用户id    
const charmStreamId; // 流id    
	bool mEnableVideo;    //启用视频    
	bool mEnableAudio;    // 启用音频    
	bool mEnableData;     // 启用数据通道（暂时无效）    
	ePRTCMeidaType mStreamMtype;// 流类型        
} tPRTCStreamInfo;    
```

<a name='struct-ePRTCWaterMarkPos'></a>


###  4.6  录制水印位置

```cpp
typedef enum {    
    PRTC_WATERMARKPOS_LEFTTOP = 1, //左上    
    PRTC_WATERMARKPOS_LEFTBOTTOM， // 左下    
    PRTC_WATERMARKPOS_RIGHTTOP， // 右上    
    PRTC_WATERMARKPOS_LEFTBOTTOM， // 右下    
} ePRTCWaterMarkPos;    
```

<a name='struct-ePRTCWaterMarkType'></a>

###  4.7  水印类型

```cpp
typedef enum {    
	PRTC_WATERMARK_TYPE_TIME = 1, // 时间水印    
	PRTC_WATERMARK_TYPE_PIC, // 图片水印    
	PRTC_WATERMARK_TYPE_TEXT, // 文字水印    
} ePRTCWaterMarkType;    
```

<a name='struct-tPRTCMuteSt'></a>

###  4.8  Mute操作结构体

```cpp
typedef struct {        
	const charmUserId; // 用户id    
    const charmStreamId; // 流id    
	bool mMute;  //true 关闭媒体  false 打开媒体    
	ePRTCMeidaType mStreamMtype; // 媒体流类型    
} tPRTCMuteSt;    
```

<a name='struct-ePRTCRecordProfile'></a>

###  4.9  录制输出等级

```cpp
typedef enum {
    PRTC_RECORDPROFILE_SD = 1, //标清 640*360
	PRTC_RECORDPROFILE_HD,    // 高清  1280*720
	PRTC_RECORDPROFILE_HDPLUS, //超清 1920*1080
} ePRTCRecordProfile;
```

<a name='struct-ePRTCRecordType'></a>

###  4.10  录制媒体类型

```cpp
typedef enum {
    PRTC_RECORDTYPE_AUDIOONLY = 1,  //直录音频（混音）
    PRTC_RECORDTYPE_AUDIOVIDEO     // 录制混音混流
} ePRTCRecordType;
```

<a name='struct-tPRTCRecordConfig'></a>

###  4.11  录制配置信息

```cpp
typedef struct PRTCRecordConfig {
	const charmMainviewuid;   //录制的主流用户id
	const charmBucket;        //存储bucket
	const charmBucketRegion;  //存储region
	ePRTCRecordProfile mProfile;  //录制profile
	ePRTCRecordType mRecordType;  //录制类型
	ePRTCWaterMarkPos mWatermarkPos;  //水印位置
	ePRTCMeidaType mMainviewmediatype;  //主流的媒体类型

	ePRTCWaterMarkType mWaterMarkType;   //水印类型
	const charmWatermarkUrl;		//水印url  为图片水印时
	bool mIsaverage;				//是否自动混流 (true .混流全部，false:手动指定流合流)
	int mMixerTemplateType;			//模板类型

	//新版录制新增参数
	tPRTCRelayStream *mStreams; //混流的用户
	int mStreamslength; //混流的用户长度
	int mLayout; // 0.取决于mIsaverage 1.流式布局 2.讲课模式 3.自定义布局 4.模板自适应1 5.模板自适应2


	PRTCRecordConfig() {
		mWatermarkUrl = nullptr;
		mMainviewuid = nullptr;
		mBucket = nullptr;
		mBucketRegion = nullptr;
		mStreams = nullptr;
		mLayout = MIX_LAYOUT_OLD;
	}
}tPRTCRecordConfig;
```

<a name='struct-ePRTCRenderMode'></a>

###  4.12  渲染模式

```cpp
typedef enum {
    PRTC_RENDER_MODE_DEFAULT = 0, //默认平铺
    PRTC_RENDER_MODE_FIT, //保持比例
    PRTC_RENDER_MODE_FILL   //平铺
} ePRTCRenderMode;
```

<a name='struct-ePRTCLogLevel'></a>

###  4.13  日志级别

```cpp
typedef enum {
	PRTC_LOG_LEVEL_DEBUG,
	PRTC_LOG_LEVEL_INFO,
	PRTC_LOG_LEVEL_WARN,
	PRTC_LOG_LEVEL_ERROR,
	PRTC_LOG_LEVEL_NONE,
} ePRTCLogLevel;
```

<a name='struct-ePRTCVideoProfile'></a>

###  4.14  视频质量参数

```cpp
typedef enum {
    PRTC_VIDEO_PROFILE_NONE = -1,
	PRTC_VIDEO_PROFILE_320_180 = 1,
	PRTC_VIDEO_PROFILE_320_240 = 2,
	PRTC_VIDEO_PROFILE_640_360 = 3,
	PRTC_VIDEO_PROFILE_640_480 = 4,
	PRTC_VIDEO_PROFILE_1280_720 = 5,
	PRTC_VIDEO_PROFILE_1920_1080 = 6，
    PRTC_VIDEO_PROFILE_1920_1080_PLUS = 7// 1920*2*1080
} ePRTCVideoProfile;
```

 - 不同视频质量对应的帧率、码率   

| 分辨率|帧率|码率(Kbps)|
|-|-|-|
| 320_180 |25|300|
| 320_240 |25|400|
| 640_360 |25|500|
| 640_480 |25|600|
| 1280_720 |25|1000|
| 1920_1080 |15|1500|
| 自定义|15-30|1500以内|


<a name='struct-ePRTCScreenProfile'></a>

###  4.15  桌面输出参数

```cpp
typedef enum {
    PRTC_SCREEN_PROFILE_LOW = 1, 		//640*360
	PRTC_SCREEN_PROFILE_MIDDLE = 2, 	//960*540
	PRTC_SCREEN_PROFILE_HIGH = 3，		// 最大1m码率 5帧  720P
	PRTC_SCREEN_PROFILE_HIGH_PLUS = 4  	// 最大1.5m码率 5帧 1080P
	PRTC_SCREEN_PROFILE_HIGH_1 = 5,    	 //最大2m码率 25帧 720P
	PRTC_SCREEN_PROFILE_HIGH_PLUS_1 = 6,	//最大2.5m码率 25帧  1080P
	PRTC_SCREEN_PROFILE_HIGH_0 = 7,     	//最大1.6m码率 15帧 720P
	PRTC_SCREEN_PROFILE_HIGH_PLUS_0 = 8 	//最大2m码率 18帧 1080P
} ePRTCScreenProfile;
```

 - 不同视频质量对应的帧率、码率   

|参数 | 分辨率|帧率|码率(Kbps)|
|-|-|-|-|
|LOW | 640_360 |5|500|
|MIDDLE | 960_540 |5|600|
|HIGH | 1280_720 |5|1000|
|HIGH_0| 1280_720 |15|1600|
|HIGH_1| 1280_720 |25|2000|
|HIGH_PLUS| 1920_1080 |5|1500|
|HIGH_PLUS_0| 1920_1080 |18|2000|
|HIGH_PLUS_1 | 1920_1080 |25|2500|

<a name='struct-tPRTCScreenPargram'></a>

###  4.16  桌面采集参数

```cpp
typedef struct
{
	long mScreenId; // 窗或者桌面id标识
	int  mXpos; // 起始x坐标
	int mYpos; // 起始y坐标
	int mWidth;// 采集宽度
	int mHeight; // 采集高度
} tPRTCScreenPargram;
```

<a name='struct-ePRTCDesktopType'></a>

###  4.17  桌面采集类型

```cpp
typedef enum {
	PRTC_DESKTOPTYPE_SCREEN = 1, 采集桌面
	PRTC_DESKTOPTYPE_WINDOW 采集窗口
} ePRTCDesktopType;
```

<a name='struct-tPRTCDeskTopInfo'></a>

###  4.18  桌面参数

```cpp
typedef struct
{
	ePRTCDesktopType mType;  桌面类型
	int mDesktopId;  id 标识
	char mDesktopTitle[MAX_WINDOWS_TILE_LEN]; //桌面标题
} tPRTCDeskTopInfo;
```

<a name='struct-ePRTCUserStreamRoleCHANNEL'></a>

###  4.19  通道类型

```cpp
typedef enum {
	PRTC_CHANNEL_TYPE_COMMUNICATION,   // 实时互动模式,
    PRTC_CHANNEL_TYPE_BROADCAST      // 直播模式
} ePRTCUserStreamRole;
```

<a name='struct-ePRTCUserStreamRoleSTREAM'></a>

###  4.20  流权限

```cpp
typedef enum {
	PRTC_USER_STREAM_ROLE_PUB, // 上行推流
	PRTC_USER_STREAM_ROLE_SUB, // 下行拉流
	PRTC_USER_STREAM_ROLE_BOTH //双向推拉流
} ePRTCUserStreamRole;
```

<a name='struct-tPRTCVideoCanvas'></a>

###  4.21  渲染窗口

```cpp
typedef struct 
{
    voidmVideoView;   // 渲染的窗口句柄
    const charmUserId; // 用户id
    const charmStreamId; //流id
	ePRTCMeidaType mStreamMtype; // 媒体流类型
    ePRTCRenderMode mRenderMode;  // 渲染模式
    ePRTCRenderType mRenderType; // 自定义渲染 mVideoView 指定为自己的render 扩展类
} tPRTCVideoCanvas;
```

<a name='struct-tPRTCAuth'></a>

###  4.22  登录信息类

```cpp
typedef struct 
{
    const charmAppId; // 平台分配的appid
	const charmRoomId; // room 标识
	const charmUserId; // 用户标识
	const charmUserToken; // 用户通过用户服务器获取的token
} tPRTCAuth;
```

<a name='struct-tPRTCStreamStats'></a>

###  4.23  当前媒体状态统计

```cpp
typedef struct {
	const charmUserId; // 用户id
    const charmStreamId; //流id
	int mStreamMtype;// 媒体流类型 摄像头 桌面
	int mTracktype; // 媒体轨道类型 1 audio 2 video
	int mAudioBitrate = 0;     // audio bitrate,unit:bps
	int mVideoBitrate = 0;
	int mVideoWidth = 0;     // video width
	int mVideoHeight = 0;     // video height
	int mVideoFrameRate = 0;     // video frames per secon
	float mPacketLostRate = 0.0f;
} tPRTCStreamStats;
```

<a name='struct-tPRTCRecordInfo'></a>

###  4.24  录制信息回调

```cpp
typedef struct {
	const charmRecordId;
	const charmFileName;
	const charmRegion;
	const charmBucket;
	const charmRoomid;
} tPRTCRecordInfo;
```

<a name='struct-tPRTCAudioFrame'></a>

###  4.25  音频帧

```cpp
typedef struct {
	const charmUserId;
	const charmStreamId;
	voidmAudioData; // 内存
	int mBytePerSimple; // 采样位数16bit
	int mSimpleRate;  // 采样频率
	int mChannels;    // 声道数
	int mNumSimples;  //采集样本数
} tPRTCAudioFrame;
```

<a name='struct-ePRTCVideoFrameType'></a>

###  4.26  视频数据帧类型

```cpp
typedef enum {
	PRTC_VIDEO_FRAME_TYPE_I420 = 1,
	PRTC_VIDEO_FRAME_TYPE_RGB24,
	PRTC_VIDEO_FRAME_TYPE_RGBA,
	PRTC_VIDEO_FRAME_TYPE_ARGB,
} ePRTCVideoFrameType;
```

<a name='struct-tPRTCVideoFrame'></a>

###  4.27  视频数据帧

```cpp
typedef struct {
	unsigned charmDataBuf;
	int mWidth;
	int mHeight;
	ePRTCVideoFrameType mVideoType;
} tPRTCVideoFrame;
```

<a name='struct-PRTCEventListener'></a>

###  4.28  消息回调事件接口类

下面所有code 为0 代表成功，其他代表失败。

```cpp
class  PRTCEventListener
{
public：
// 服务器断开
virtual void onServerDisconnect() {}
// 加入房间通知
virtual void onJoinRoom(int code, const charmsg, const charuid, const charroomid) {}
// 离开房间通知
virtual void onLeaveRoom(int code, const charmsg, const charuid, const charroomid) {}
//房间重连中
virtual void onRejoining(const charuid, const charroomid) {}
// 房间重连成功
virtual void onReJoinRoom(const charuid, const charroomid) {}
// 本地流发布结果回调
virtual void onLocalPublish(const int code, const charmsg, tPRTCStreamInfo & info) {}
// 本地流取消发布结果回调
virtual void onLocalUnPublish(const int code, const charmsg, tPRTCStreamInfo & info) {}
// 远端有用户加入房间
virtual void onRemoteUserJoin(const charuid) {}
// 远端有用户离开房间
virtual void onRemoteUserLeave(const charuid,int reson) {}
// 远端用户发布视频
virtual void onRemotePublish(tPRTCStreamInfo & info) {}
// 远端用户取消发布视频
virtual void onRemoteUnPublish(tPRTCStreamInfo & info) {}
// 订阅某条视频流回调
virtual void onSubscribeResult(const int code, const charmsg, tPRTCStreamInfo & info) {}
// 取消订阅某条视频流回调
virtual void onUnSubscribeResult(const int code, const charmsg, tPRTCStreamInfo & info) {}
// 操作本地媒体流结果回调
virtual void onLocalStreamMuteRsp(const int code, const charmsg,	ePRTCMeidaType mediatype, PRTCTracktype tracktype, bool mute) {}
// 操作远端媒体流结果回调
	virtual void onRemoteStreamMuteRsp(const int code, const charmsg, const charuid, ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {}
// 远端媒体流状态回调
	virtual void onRemoteTrackNotify(const charuid, ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {}
//发送状态信息
	virtual void onSendRTCStats(tPRTCStreamStats & rtstats) {}
//接收状态信息
	virtual void onRemoteRTCStats(tPRTCStreamStats rtstats) {}
//开启录制回调
virtual void onStartRecord (const int code, const charmsg, tPRTCRecordInfo& info) {}
// 结束录制回调
virtual void onStopRecord (const int code, const charmsg, const charrecordid) {}
// 麦克风能量回调
	virtual void onMiceAudioLevel(int volume) {} 
// 远端能量回调
	virtual void onRemoteAudioLevel(const charuid, int volume) {}
// 踢下线
virtual void onKickoff(int code) {}
// 警告
virtual void onWarning(int warn) {}
// 错误
    virtual void onError(int error) {}
//网络质量评分回调
	virtual void onNetworkQuality(const charuid, ePRTCNetworkQuality&rtype, ePRTCQualityType& Quality) {}
//旁推状态回调
	virtual void onRtmpStreamingStateChanged(const int 	state, const charurl, int code) {};
//旁推更新混合流回调
	virtual void onRtmpUpdateMixStreamRes(ePRTCRtmpOpration& cmd,const int code, const charmsg) {};
};
```

<a name='struct-PRTCMediaListener'></a>

###  4.29  音频测试回调

```cpp
class  PRTCMediaListener
{
public:
	// 音频能量回调   （0--255）
    virtual void onMiceAudioLevel(int volume) {} 
};
```

<a name='struct-PRTCAudioFrameCallback'></a>

###  4.30  音频数据回调

```cpp
class  PRTCAudioFrameCallback
{
public:
	//本地音频回调
	virtual void onLocalAudioFrame(tPRTCAudioFrameaudioframe) {}
   // 远端混音数据
	virtual void onRemoteMixAudioFrame(tPRTCAudioFrameaudioframe) {} 
};
```

<a name='struct-PRTCExtendVideoCaptureSource'></a>

###  4.31  视频扩展数据源

用户可以扩展自己的视频输入 音频通过doCaptureFrame 采集数据。

```cpp
class  PRTCExtendVideoCaptureSource
{
public:
	virtual  bool doCaptureFrame(tPRTCVideoFramevideoframe) = 0; 
};
```

<a name='struct-PRTCExtendVideoRender'></a>

###  4.32  视频数据回调

用户结合渲染 可以获取数据进行自己渲染。

```cpp
class PRTCExtendVideoRender
{
public:
	virtual  void onRemoteFrame(const tPRTCVideoFramevideoframe) = 0;
};
```

<a name='struct-PRTCVideoFrameObserver'></a>

###  4.33  视频数据回调监听类（yuv420p格式）

引擎内存回调camera 采集数据 和 扩展数据源使用方便做视频前置处理。

```cpp
class  PRTCVideoFrameObserver
{
public:
	virtual  void onCaptureFrame(unsigned charvideoframe, int buflen) = 0;
};
```

<a name='struct-ePRTCRenderType'></a>

###  4.34  视频渲染类型

```cpp
typedef enum {
    PRTC_RENDER_TYPE_GDI = 1,
	PRTC_RENDER_TYPE_D3D = 2，
    PRTC_RENDER_TYPE_EXTEND = 3
} ePRTCRenderType;
```

<a name='struct-ePRTCVideoCodec'></a>

###  4.35  视频编码类型

```cpp
typedef enum {
	PRTC_CODEC_VP8 = 1, //default
	PRTC_CODEC_H264
} ePRTCVideoCodec;
```

<a name='struct-tPRTCVideoConfig'></a>

###  4.36  视频参数

```cpp
typedef struct {
	int mWidth; // 宽
	int mHeight; // 高
	int mFrameRate; // 帧率
} tPRTCVideoConfig;
```

<a name='struct-ePRTCNetworkQuality'></a>

###  4.37  上下行网络类型

```cpp
typedef enum {
	PRTC_NETWORK_TX = 1,  //上行
	PRTC_NETWORK_RX = 2,  //下行
}ePRTCNetworkQuality;
```

<a name='struct-ePRTCQualityType'></a>

###  4.38  网络质量评分

```cpp
typedef enum {
	PRTC_QUALITY_UNKNOWN = 0, //未知
	PRTC_QUALITY_DOWN = 1,  //很坏
	PRTC_QUALITY_BAD = 2,  //勉强能沟通但不顺畅
	PRTC_QUALITY_POOR =  3, //用户主观感受有瑕疵但不影响沟通
	PRTC_QUALITY_GOOD = 4, // 用户主观感觉和 excellent 差不多
	PRTC_QUALITY_EXCELLENT = 5, //网络质量极好
}ePRTCQualityType;
```

<a name='struct-PRTCDeviceChanged'></a>

###  4.39  设备热插拔回调

```cpp
class PRTCDeviceChanged
{
public:
	virtual void onInterfaceArrival(const chardccname, int len) {}  //设备插入
	virtual void onInterfaceRemoved(const chardccname, int len) {}  //设备移除
	virtual void onInterfaceChangeValue(const chardccname, int len) {} //设备属性改变
	virtual ~PRTCDeviceChanged() {}
};
```


<a name='struct-PRTCExtendAudioCaptureSource'></a>

###  4.40  音频外部采集

```cpp
class  PRTCExtendAudioCaptureSource
{
public:
	virtual ~PRTCExtendAudioCaptureSource() {}
	virtual  bool doCaptureAudioFrame(tPRTCAudioFrameaudioframe) = 0;
};
```

<a name='struct-tPRTCRelayStream'></a>

###  4.41  转推的流

```cpp
typedef struct PRTCRelayStream {
	const charmUid;          //用户id
	ePRTCMeidaType mType; //媒体类型 1摄像头 2桌面
	PRTCRelayStream() {
		mUid = nullptr;
		mType = PRTC_MEDIATYPE_NONE;
	}
}tPRTCRelayStream;
```

<a name='struct-ePRTCMixLayout'></a>

###  4.42  转推混流操作类型

```cpp
typedef enum {
	MIX_LAYOUT_OLD,      //兼容之前模板
	MIX_LAYOUT_FLOW,	 //流式布局
	MIX_LAYOUT_TEACH,			 //讲课布局
	MIX_LAYOUT_CUSTOM,    //自定义
	MIX_LAYOUT_ADAPTION1, //自适应模板1
	MIX_LAYOUT_ADAPTION2, //自适应模板2
}ePRTCMixLayout;
```

<a name='struct-PRTCTranscodeConfig'></a>

###  4.43  转推配置

```cpp
typedef struct PRTCTranscodeConfig {
	tPRTCBackgroundColor mbgColor;  //背景色
	int mFramerate; //帧率
	int mBitrate;   //码率
	const char mMainViewUid; //主讲人的uid
	int mMainviewType; //主讲人放置的流类型
	int mWidth;  //输出分辨率宽度
	int mHeight; //输出分辨率高度
	ePRTCMixLayout mLayout; // 1.流式布局 2.讲课模式 3.自定义布局 4.模板自适应1 5.模板自适应2
	const char mStyle; //mLayout=3 时自定义风格内容
	int mLenth;
	tPRTCRelayStream *mStreams; //混流的用户
	int mStreamslength; //长度
	PRTCTranscodeConfig()
	{
		mLayout = MIX_LAYOUT_TEACH;
		mMainViewUid = nullptr;
		mStreams = nullptr;
		mStyle = nullptr;
		mStreamslength = 0;
	}
}tPRTCTranscodeConfig;
```
<a name='struct-ePRTCExtendMediaDataMode'></a>

###  4.44 外部源模式

```cpp
typedef enum {
    PRTC_EMDM_UNKNOWN = 0,
    PRTC_EMDM_PUSH,       //推流模式
    PRTC_EMDM_PULL,       //拉流模式
}ePRTCExtendMediaDataMode;
```

<a name='struct-ePRTCAudioProfile'></a>

###  4.45  音频编码属性

```cpp
typedef enum {
    PRTC_Audio_Profile_Default = 0,  //默认模式， 单声道， 32K码率
    PRTC_Audio_Profile_Stand,  //标准模式， 单声道， 64K码率
    PRTC_Audio_Profile_Stand_Stereo, //标准立体声， 双声道， 80K码率
    PRTC_Audio_Profile_Hight,   //高音质模式， 单声道， 96K码率
    PRTC_Audio_Profile_Hight_Stereo, //高音质立体声， 双声道， 128K码率
    PRTC_Audio_Profile_Stand_Stereo_Disable_2A, // 标准立体声， 双声道， 80K码率， 禁用AEC， AGC
    PRTC_Audio_Profile_Hight_Disable_2A,   //高音质模式， 单声道， 96K码率， 禁用AEC， AGC
    PRTC_Audio_Profile_Hight_Stereo_Disable_2A, //高音质立体声， 双声道， 128K码率， 禁用AEC， AGC
}ePRTCAudioProfile;
```