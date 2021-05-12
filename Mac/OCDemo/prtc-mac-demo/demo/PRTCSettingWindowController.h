//
//  PRTCSettingWindowController.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/5.
//

#import <Cocoa/Cocoa.h>
#import "PRTCConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SettingComplete)(PRTCConfigModel *config);


@interface PRTCSettingWindowController : NSWindowController

@property (copy) SettingComplete settingComplete;


@end

NS_ASSUME_NONNULL_END
