//
//  PRTCSettingWindowController.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/5.
//
//PRTC_VIDEO_PROFILE_NONE = -1,
//PRTC_VIDEO_PROFILE_320_180 = 1,
//PRTC_VIDEO_PROFILE_320_240 = 2,
//PRTC_VIDEO_PROFILE_640_360 = 3,
//PRTC_VIDEO_PROFILE_640_480 = 4,
//PRTC_VIDEO_PROFILE_1280_720 = 5,
//PRTC_VIDEO_PROFILE_1920_1080 = 6,
//PRTC_VIDEO_PROFILE_240_180 = 7,
//PRTC_VIDEO_PROFILE_480_360 = 8,
//PRTC_VIDEO_PROFILE_960_720 = 9

#import "PRTCSettingWindowController.h"

@interface PRTCSettingWindowController ()
@property(strong) PRTCConfigModel *config;

/// 频道类型
@property (assign) NSInteger currentchannelType;

/// 自动发布
@property (weak) IBOutlet NSButton *autoPublishCheck;

/// 自动订阅
@property (weak) IBOutlet NSButton *autoSubscribeCheck;

/// 自动发布视频
@property (weak) IBOutlet NSButton *autoPublishVideoCheck;

/// 自动发布音频
@property (weak) IBOutlet NSButton *autoPublishAudioCheck;

/// 自动发布桌面
@property (weak) IBOutlet NSButton *autoPublishScreenCheck;

/// 发布权限
@property (weak) IBOutlet NSButton *rolePublishCheck;

/// 订阅权限
@property (weak) IBOutlet NSButton *roleSubscribeCheck;

/// 纯音频
@property (weak) IBOutlet NSButton *onlyAudioCheck;

/// 分辨率
@property (nonatomic, assign) NSInteger  videoProfle;

/// 编码格式
@property (nonatomic, assign) NSInteger  videoCodec;
@end

@implementation PRTCSettingWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
        
    self.currentchannelType = 1;
    
    _config = [PRTCConfigModel new];
    

}


/// 房间类型
- (IBAction)setupChannelType:(NSButton *)sender {

    self.currentchannelType = sender.tag;
}




/// 分辨率
- (IBAction)setupVideoProfile:(NSPopUpButton *)sender {
    _config.videoProfle = sender.indexOfSelectedItem + 1;
    
    
}

/// 编码格式
- (IBAction)setupVideoCodec:(NSPopUpButton *)sender {
    _config.videoCodec = sender.indexOfSelectedItem + 1;
}

/// 控制自动发布
- (IBAction)checkAutoPublish:(NSButton *)sender {
    _autoPublishVideoCheck.state = sender.state;
//    if (_onlyAudioCheck.state == NSControlStateValueOn) {
//        _autoPublishAudioCheck.state = NSControlStateValueOn;
//    } else {
//        _autoPublishAudioCheck.state = sender.state;
//    }
    
}

- (IBAction)checkOnlyAudio:(NSButton *)sender {
    _autoPublishVideoCheck.state = !sender.state;
    if (sender.state == NSControlStateValueOff) {
        _autoPublishAudioCheck.state = !sender.state;

    }
}



/// 保存
- (IBAction)saveSetting:(NSButton *)sender {
    _config.channelType = _currentchannelType;
    _config.autoPublish = _autoPublishCheck.state == NSControlStateValueOn;
    _config.autoSubscribe = _autoSubscribeCheck.state == NSControlStateValueOn;
    _config.autoPublishVideo = _autoPublishVideoCheck.state == NSControlStateValueOn;
    _config.autoPublishAudio = _autoPublishAudioCheck.state == NSControlStateValueOn;
    _config.autoPublishScreen = _autoPublishScreenCheck.state == NSControlStateValueOn;
    _config.rolePublish = _rolePublishCheck.state = NSControlStateValueOn;
    _config.roleSubscribe = _roleSubscribeCheck.state = NSControlStateValueOn;
    _config.isOnlyAudio = _onlyAudioCheck.state == NSControlStateValueOn;
    
    
    if (_settingComplete) {
        _settingComplete(_config);
    }
    
    [self.window orderOut:nil];
    
}

- (void)dealloc {
    
    NSLog(@"-----%@ dealloc-----", self);
}

@end
