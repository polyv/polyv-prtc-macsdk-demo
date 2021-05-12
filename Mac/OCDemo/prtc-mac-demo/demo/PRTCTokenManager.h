//
//  PRTCGetToken.h
//  PRTCSDK
//
//  Created by tony on 2019/4/20.
//  Copyright © 2019年 PRTC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PRTCTokenManager : NSObject


/// 测试获取token
/// @param appID appID
/// @param userID userID
/// @param roomID roomID
/// @param appSecret appSecret
+ (NSString *)getTokenWithAppId:(NSString *)appID userID:(NSString *)userID roomID:(NSString *)roomID  andAppSecret:(NSString *)appSecret;



@end
