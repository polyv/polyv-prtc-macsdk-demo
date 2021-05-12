//
//  PRTCMainViewController.h
//  PRTC
//
//  Created by PRTC on 2020/10/12.
//  Copyright © 2020 PRTC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PRTCConfigModel.h"
#import "PRTCEngineObjc.h"

NS_ASSUME_NONNULL_BEGIN




typedef void(^LeaveRoomComplete)(void);

@interface PRTCMainViewController : NSViewController
@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *userId;

@property(nonatomic,strong) PRTCConfigModel *config;

@end

NS_ASSUME_NONNULL_END
