//
//  PRTCLoginWindow.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/29.
//

#import "PRTCLoginWindow.h"

@implementation PRTCLoginWindow

- (instancetype)initWithContentRect:(NSRect)contentRect
                          styleMask:(NSUInteger)aStyle
                            backing:(NSBackingStoreType)bufferingType
                              defer:(BOOL)flag{
    self = [super initWithContentRect:contentRect
                            styleMask:aStyle
                              backing:bufferingType
                                defer:flag];
    if (self) {
        [self setHasShadow:YES];
//        [self setOpaque:NO];
//        [self setBackgroundColor:[NSColor clearColor]];
        [self setMovableByWindowBackground:YES];
    }
    return self;
}
- (void)setContentView:(__kindof NSView *)contentView{
    
    // 需要使用layer
    contentView.wantsLayer            = YES;
    contentView.layer.frame           = contentView.frame;
    contentView.layer.cornerRadius    = 5.0;
    contentView.layer.masksToBounds   = YES;
    
    [super setContentView:contentView];
}

- (BOOL)canBecomeKeyWindow{
    return YES;
}
- (BOOL)canBecomeMainWindow{
    return YES;
}
@end
