//
//  PRTCConfigModel.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PRTCConfigModel : NSObject

/// 频道类型
@property (nonatomic, assign) NSInteger channelType;

/// 自动发布
@property (nonatomic, assign) BOOL  autoPublish;

/// 自动订阅
@property (nonatomic, assign) BOOL  autoSubscribe;

/// 自动发布视频
@property (nonatomic, assign) BOOL  autoPublishVideo;

/// 自动发布音频
@property (nonatomic, assign) BOOL  autoPublishAudio;

/// 自动发布桌面
@property (nonatomic, assign) BOOL  autoPublishScreen;

/// 发布权限
@property (nonatomic, assign) BOOL  rolePublish;

/// 订阅权限
@property (nonatomic, assign) BOOL  roleSubscribe;

/// 分辨率
@property (nonatomic, assign) NSInteger  videoProfle;

/// 编码格式
@property (nonatomic, assign) NSInteger  videoCodec;

/// 纯音频
@property (nonatomic, assign) BOOL  isOnlyAudio;
@end

NS_ASSUME_NONNULL_END
