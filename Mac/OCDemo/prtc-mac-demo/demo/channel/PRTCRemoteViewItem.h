//
//  PRTCRemoteViewItem.h
//  PRTC
//
//  Created by PRTC on 2020/10/12.
//  Copyright © 2020 PRTC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN
@class PRTCStream;

/**
 type   0: 为摄像头
    1: 麦克风
 */
typedef void(^PRTCMuteComplete)(PRTCStream *stream, int type, BOOL mute);

@interface PRTCRemoteViewItem : NSCollectionViewItem

@property (nonatomic, strong) PRTCStream *streamModel;

@property (strong, nonatomic) PRTCMuteComplete muteComplete;

@end

NS_ASSUME_NONNULL_END
