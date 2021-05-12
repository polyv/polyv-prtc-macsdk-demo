//
//  PRTCConfigModel.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/5.
//

#import "PRTCConfigModel.h"

@implementation PRTCConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /// 频道类型
        _channelType  = 1;

        /// 自动发布
        _autoPublish = YES;

        /// 自动订阅
        _autoSubscribe = YES;

        /// 自动发布视频
        _autoPublishVideo = YES;

        /// 自动发布音频
        _autoPublishAudio = YES;

        /// 自动发布桌面
        _autoPublishScreen = NO;

        /// 发布权限
        _rolePublish = YES;

        /// 订阅权限
        _roleSubscribe = YES ;

        /// 分辨率640*360
        _videoProfle = 4;

        /// 编码格式H264
        _videoCodec = 2;
        
        _isOnlyAudio = NO;
    }
    return self;
}


@end
