//
//  YJFileCaptureController.h
//  PRTCSdk-ios-demo
//
//  Created by PRTC on 2020/9/2.
//  Copyright © 2020 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PRTCFileCaptureController;
@protocol PRTCFileCaptureControllerDelegate <NSObject>

- (void)capturer:(PRTCFileCaptureController *)fileCaptureController didCaptureVideoPixelBufferRef:(CVPixelBufferRef)pixelBufferRef timestamp:(CMTime)timestamp ;

- (void)capturer:(PRTCFileCaptureController *)fileCaptureController didCaptureVideodata:(NSData *)data ;



@end
typedef void(^YJFileVideoCapturerErrorBlock)(NSError *error);

@interface PRTCFileCaptureController : NSObject
@property (nonatomic, weak) id<PRTCFileCaptureControllerDelegate> delegate;
- (void)startCapturingFromFileNamed:(NSString *)nameOfFile
                            onError:(__nullable YJFileVideoCapturerErrorBlock)errorBlock;

/**
 * Immediately stops capture.
 */
- (void)stopCapture;
@end

NS_ASSUME_NONNULL_END
