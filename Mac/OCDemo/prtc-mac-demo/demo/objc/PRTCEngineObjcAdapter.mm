//
//  PRTCEngineObjcAdapter.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/5.
//

#import "PRTCEngineObjcAdapter.h"
#define PRTCCstr2ocStr(cstr) \
({\
(cstr ==NULL) ? @"" : [NSString stringWithUTF8String:cstr];\
})

class PRTCEngineEventListener: public IPRTCEventListener
{
public:
    PRTCEngineEventListener(PRTCEngineObjcAdapter *adapter) {
        adapter_ = adapter;
    }
    ~PRTCEngineEventListener(){
        NSLog(@"----PRTCEngineEventListener dealloc---");
    }
    virtual void onServerDisconnect() {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onServerDisconnect)]) {
            [adapter_.engineDelegate onServerDisconnect];
        }
    }
    ///加入房间回调
    ///@param code 错误码  0成功
    ///@param msg 错误信息
    ///@param uid 用户id
    ///@param roomid 房间id
    virtual void onJoinRoom(int code, const char* msg, const char* uid, const char* roomid) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onJoinRoom:msg:uid:roomid:)]) {
            [adapter_.engineDelegate onJoinRoom:code msg:PRTCCstr2ocStr(msg) uid:PRTCCstr2ocStr(uid) roomid:PRTCCstr2ocStr(roomid)];
        }
    }

    ///离开房间回调
    ///@param code 错误码  0成功
    ///@param msg 错误信息
    ///@param uid 用户id
    ///@param roomid 房间id
    virtual void onLeaveRoom(int code, const char* msg, const char* uid, const char* roomid) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onLeaveRoom:msg:uid:roomid:)]) {
            [adapter_.engineDelegate onLeaveRoom:code msg:PRTCCstr2ocStr(msg) uid:PRTCCstr2ocStr(uid) roomid:PRTCCstr2ocStr(roomid)];
        }
    }

    ///断线重连回调
    ///@param uid 用户id
    ///@param roomid 房间id
    virtual void onRejoining(const char* uid, const char* roomid) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRejoining:roomid:)]) {
            [adapter_.engineDelegate onRejoining:PRTCCstr2ocStr(uid) roomid:PRTCCstr2ocStr(roomid)];
        }
    }

    ///重新加入房间成功回调
    ///@param uid 用户id
    ///@param roomid 房间id
    virtual void onReJoinRoom(const char* uid, const char* roomid) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onReJoinRoom:roomid:)]) {
            [adapter_.engineDelegate onReJoinRoom:PRTCCstr2ocStr(uid) roomid:PRTCCstr2ocStr(roomid)];
        }
    }

    ///本地流发布回调
    ///@param code 错误码  0 succ
    ///@param msg 本地发布错误信息
    ///@param info 发布成功后本地流信息
    virtual void onLocalPublish(const int code, const char* msg, tPRTCStreamInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onLocalPublish:msg:info:)]) {
            [adapter_.engineDelegate onLocalPublish:code msg:PRTCCstr2ocStr(msg) info:info];
        }
    }

    ///本地流取消发布回调
    ///@param code 错误码  0 succ
    ///@param msg 本地发布错误信息
    ///@param info 取消发布成功后本地流信息
    virtual void onLocalUnPublish(const int code, const char* msg, tPRTCStreamInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onLocalUnPublish:msg:info:)]) {
            [adapter_.engineDelegate onLocalUnPublish:code msg:PRTCCstr2ocStr(msg) info:info];
        }
    }

    ///远端用户加入回调
    ///@param uid 远端用户id
    virtual void onRemoteUserJoin(const char* uid) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteUserJoin:)]) {
            [adapter_.engineDelegate onRemoteUserJoin:PRTCCstr2ocStr(uid)];
        }
    }

    ///远端用户离开回调
    ///@param uid 远端用户id
    ///@param reson 离开原因
    virtual void onRemoteUserLeave(const char* uid, int reson) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteUserLeave:reason:)]) {
            [adapter_.engineDelegate onRemoteUserLeave:PRTCCstr2ocStr(uid) reason:reson];
        }
    }

    ///远端流发布回调
    ///@param info 远端流信息
    virtual void onRemotePublish(tPRTCStreamInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemotePublish:)]) {
            [adapter_.engineDelegate onRemotePublish:info];
        }
    }

    ///远端流取消发布回调
    ///@param info 远端流信息
    virtual void onRemoteUnPublish(tPRTCStreamInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteUnPublish:)]) {
            [adapter_.engineDelegate onRemoteUnPublish:info];
        }
    }

    ///订阅回调
    ///@param code 订阅结果 0 succ
    ///@param msg 订阅提示信息
    ///@param info 订阅流信息
    virtual void onSubscribeResult(const int code, const char* msg, tPRTCStreamInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onSubscribeResult:msg:info:)]) {
            [adapter_.engineDelegate onSubscribeResult:code msg:PRTCCstr2ocStr(msg) info:info];
        }
    }

    ///取消订阅回调
    ///@param code 取消订阅结果 0 succ
    ///@param msg 订阅提示信息
    ///@param info 订阅流信息
    virtual void onUnSubscribeResult(const int code, const char* msg, tPRTCStreamInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onUnSubscribeResult:msg:info:)]) {
            [adapter_.engineDelegate onUnSubscribeResult:code msg:PRTCCstr2ocStr(msg) info:info];
        }
    }

    ///本地mute回调
    ///@param code mute回调结果 0 succ
    ///@param msg  提示信息
    ///@param mediatype 媒体类型
    ///@param tracktype track类型
    ///@param mute mute状态
    virtual void onLocalStreamMuteRsp(const int code, const char* msg,
        ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onLocalStreamMuteRsp:msg:mediatype:tracktype:mute:)]) {
            [adapter_.engineDelegate onLocalStreamMuteRsp:code msg:PRTCCstr2ocStr(msg) mediatype:mediatype tracktype:tracktype mute:mute];
        }
    }

    ///远端mute回调
    ///@param code mute回调结果 0 succ
    ///@param msg  提示信息
    ///@param uid  远端用户id
    ///@param mediatype 媒体类型
    ///@param tracktype track类型
    ///@param mute mute状态
    virtual void onRemoteStreamMuteRsp(const int code, const char* msg, const char* uid,
        ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteStreamMuteRsp:msg:uid:mediatype:tracktype:mute:)]) {
            [adapter_.engineDelegate onRemoteStreamMuteRsp:code msg:PRTCCstr2ocStr(msg) uid:PRTCCstr2ocStr(uid) mediatype:mediatype tracktype:tracktype mute:mute];
        }
    }

    ///远端音频轨或者视频轨状态回调
    ///@param uid  远端用户id
    ///@param mediatype 媒体类型
    ///@param tracktype track类型
    ///@param mute mute状态
    virtual void onRemoteTrackNotify(const char* uid,
        ePRTCMeidaType mediatype, ePRTCTrackType tracktype, bool mute) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteTrackNotify:mediatype:tracktype:mute:)]) {
            [adapter_.engineDelegate onRemoteTrackNotify:PRTCCstr2ocStr(uid) mediatype:mediatype tracktype:tracktype mute:mute];
        }
    }

    ///开启录制回调
    ///@param code  0 succ
    ///@param msg 错误提示信息
    ///@param info 录制信息
    virtual void onStartRecord(const int code, const char* msg, tPRTCRecordInfo& info) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onStartRecord:msg:info:)]) {
            [adapter_.engineDelegate onStartRecord:code msg:PRTCCstr2ocStr(msg) info:info];
        }
    }

    ///停止录制回调
    ///@param code  0 succ 0代表主动停止成功 非0代表异常停止需要重新开启
    ///@param msg 错误提示信息
    ///@param recordid 录制ID
    virtual void onStopRecord(const int code, const char* msg, const char* recordid) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onStopRecord:msg:recordid:)]) {
            [adapter_.engineDelegate onStopRecord:code msg:PRTCCstr2ocStr(msg) recordid:PRTCCstr2ocStr(recordid)];
        }
    }

    ///本地数据统计回调
    ///@param rtstats 统计信息
    virtual void onSendRTCStats(tPRTCStreamStats& rtstats) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onSendRTCStats:)]) {
            [adapter_.engineDelegate onSendRTCStats:rtstats];
        }
    }

    ///远端数据统计回调
    ///@param rtstats 统计信息
    virtual void onRemoteRTCStats(tPRTCStreamStats rtstats) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteRTCStats:)]) {
            [adapter_.engineDelegate onRemoteRTCStats:rtstats];
        }
    }

    ///远端音频能量回调
    ///@param uid 用户ID
    ///@param volume 音量大小
    virtual void onRemoteAudioLevel(const char* uid, int volume) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRemoteAudioLevel:volume:)]) {
            [adapter_.engineDelegate onRemoteAudioLevel:PRTCCstr2ocStr(uid) volume:volume];
        }
    }

    ///网络评分回调
    ///@param uid 用户ID
    ///@param rtype 网络上下型类型
    ///@param Quality 评分
    virtual void onNetworkQuality(const char* uid, ePRTCNetworkQuality&rtype, ePRTCQualityType& Quality) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onNetworkQuality:quality:qualityType:)]) {
            [adapter_.engineDelegate onNetworkQuality:PRTCCstr2ocStr(uid) quality:rtype qualityType:Quality];
        }
    }

    ///旁推状态回调
    ///@param state rtmp状态
    ///@param url cdn地址
    ///@param code 错误码
    virtual void onRtmpStreamingStateChanged(const int     state, const char* url, int code) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRtmpStreamingStateChanged:url:code:)]) {
            [adapter_.engineDelegate onRtmpStreamingStateChanged:state url:PRTCCstr2ocStr(url) code:code];
        }
    };

    ///旁推更新混合流回调
    ///@param cmd 操作类型
    ///@param code 错误码
    ///@param msg 错误信息
    virtual void onRtmpUpdateMixStreamRes(ePRTCRtmpOpration& cmd,const int code, const char* msg) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onRtmpUpdateMixStreamRes:code:msg:)]) {
            [adapter_.engineDelegate onRtmpUpdateMixStreamRes:cmd code:code msg:PRTCCstr2ocStr(msg)];
        }
    };

    ///设备报错回调
    ///@param code 设备报错回调
    virtual void onCaptureError(const int code, const int detail) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onCaptureError:detail:)]) {
            [adapter_.engineDelegate onCaptureError:code detail:detail];
        }
    }

    ///本地音频能量回调
    ///@param volume 音量大小
    virtual void onLocalAudioLevel(int volume) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onLocalAudioLevel:)]) {
            [adapter_.engineDelegate onLocalAudioLevel:volume];
        }
    }


    ///远端音频播放首帧回调
    ///@param uid 用户id
    ///@param elapsed 从加入房间到收到远端音频距离的时间
    virtual void onFirstRemoteAudioFrame(const char* uid, int elapsed) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onFirstRemoteAudioFrame:elapsed:)]) {
            [adapter_.engineDelegate onFirstRemoteAudioFrame:PRTCCstr2ocStr(uid) elapsed:elapsed];
        }
    }


    ///远端视频首帧回调
    ///@param uid 用户id
    ///@param width 宽度
    ///@param height 高度
    ///@param elapsed 从加入房间到收到远端视频渲染距离的时间
    virtual void onFirstRemoteVideoFrame(const char* uid, int width, int height, int elapsed) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onFirstRemoteVideoFrame:width:height:elapsed:)]) {
            [adapter_.engineDelegate onFirstRemoteVideoFrame:PRTCCstr2ocStr(uid) width:width height:height elapsed:elapsed];
        }
    }

    ///自定义消息接口发送结果
    /// @param code 错误
    /// @param msg
    virtual void onSendMsgRsp(int code, const char*msg) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onSendMsgRsp:msg:)]) {
            [adapter_.engineDelegate onSendMsgRsp:code msg:PRTCCstr2ocStr(msg)];
        }
    };

    ///广播消息通知
    ///@param uid 用户id
    ///@param msg 用户消息
    virtual void onBroadMsgNotify(const char*uid, const char*msg) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onBroadMsgNotify:msg:)]) {
            [adapter_.engineDelegate onBroadMsgNotify:PRTCCstr2ocStr(uid) msg:PRTCCstr2ocStr(msg)];
        }
    };

    ///踢人通知
    ///@param code 错误码
    virtual void onKickoff(int code) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onKickoff:)]) {
            [adapter_.engineDelegate onKickoff:code];
        }
    }

    ///警告回调
    ///@param warn 错误码
    virtual void onWarning(int warn) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onWarning:)]) {
            [adapter_.engineDelegate onWarning:warn];
        }
    }

    ///错误回调
    ///@param error 错误码
    virtual void onError(int error) {
        if ([adapter_.engineDelegate respondsToSelector:@selector(onError:)]) {
            [adapter_.engineDelegate onError:error];
        }
    }
private:
    PRTCEngineObjcAdapter *adapter_;
};



@implementation PRTCEngineObjcAdapter
- (instancetype)initWithEngineAdapter:(id<PRTCEngineObjcDelegate>)delegate{
    self = [super init];
    if (self) {
        _eventListener = new PRTCEngineEventListener(self);
        _engineDelegate = delegate;
        
    }
    return self;
    
    
}
- (void)dealloc
{
    NSLog(@"-----%@ dealloc-------", self);
}
@end
