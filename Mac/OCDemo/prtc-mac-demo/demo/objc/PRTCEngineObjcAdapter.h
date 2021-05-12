//
//  PRTCEngineObjcAdapter.h
//  prtc-mac-demo
//
//  Created by PRTC on 2021/2/5.
//

#import <Foundation/Foundation.h>
#import "PRTCEngineObjc.h"
#import <PRTCSDK_MAC/IPRTCEngine.h>

NS_ASSUME_NONNULL_BEGIN

@interface PRTCEngineObjcAdapter : NSObject

@property(nonatomic, readonly) IPRTCEventListener *eventListener;

@property(nonatomic, readonly) id<PRTCEngineObjcDelegate> engineDelegate;


- (instancetype)initWithEngineAdapter:(id<PRTCEngineObjcDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
