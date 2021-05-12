//
//  PRTCDeviceTestController.m
//  prtc-mac-demo
//
//  Created by PRTC on 2021/3/11.
//

#import "PRTCDeviceTestController.h"
#import "PRTCMediaDeviceObjc.h"

#define  VOLUME_ITEM_COUNT  17


@interface PRTCDeviceTestController ()<PRTCRecordingeDelegate>
{
    PRTCMediaDeviceObjc *_mediaDeviceObjc;
    
    int _currentCamaroIndex;
    int _currentMicIndex;
    int _currentPlayoutIndex;
    
    
}

@property (nonatomic, strong) NSMutableArray *lineArray;

@property (strong) NSView *testVideoView;


@property (weak) IBOutlet NSView *renderView;
@property (weak) IBOutlet NSPopUpButton *popUpBtnCamaro;
@property (weak) IBOutlet NSPopUpButton *popUpBtnMic;
@property (weak) IBOutlet NSPopUpButton *popUpBtnPlayout;
@property (weak) IBOutlet NSView *volumeProgressBg;

@property (weak) IBOutlet NSButton *testCamBtn;
@property (weak) IBOutlet NSButton *testMicBtn;
@property (weak) IBOutlet NSButton *testPlayBtn;




@end

@implementation PRTCDeviceTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    PRTCMediaDeviceObjc *mediaDeviceObjc = [PRTCMediaDeviceObjc shared];
    
    _mediaDeviceObjc = mediaDeviceObjc;
    
    self.renderView.wantsLayer = YES;
    self.renderView.layer.backgroundColor = [NSColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:0.6].CGColor;
    
    
    _currentCamaroIndex = 0;
    _currentMicIndex = 0;
    _currentPlayoutIndex = 0;
    
    _lineArray = [NSMutableArray new];

    [self initvolumeProgressBg];
    
    
}







- (void)viewWillAppear {
    [super viewWillAppear];

    // 摄像头
    [_mediaDeviceObjc InitVideoMoudle];
    int num = [_mediaDeviceObjc getCamNums];
    for (int i = 0; i < num; i++) {
        tPRTCDeviceInfo info;
        [_mediaDeviceObjc getVideoDevInfo:i info:&info];
        [self.popUpBtnCamaro addItemWithTitle:[NSString stringWithUTF8String:info.mDeviceName]];
    }
    
    
    // 麦克风
    [_mediaDeviceObjc InitAudioMoudle];
    num = [_mediaDeviceObjc getRecordDevNums];
    for (int i = 0; i < num; i++) {
        tPRTCDeviceInfo info;
        [_mediaDeviceObjc getRecordDevInfo:i info:&info];
        [self.popUpBtnMic addItemWithTitle:[NSString stringWithUTF8String:info.mDeviceName]];
        
    }
    [_mediaDeviceObjc setRecordingDeviceVolume:100];

    
    // 扬声器
    num = [_mediaDeviceObjc getPlayoutDevNums];
    for (int i = 0; i < num; i++) {
        tPRTCDeviceInfo info;
        [_mediaDeviceObjc getPlayoutDevInfo:i info:&info];
        [self.popUpBtnPlayout addItemWithTitle:[NSString stringWithUTF8String:info.mDeviceName]];
    }
    [_mediaDeviceObjc setPlaybackDeviceVolume:100];

    
}


- (void)viewWillDisappear {
    [super viewWillDisappear];
    
    
    if (self.testCamBtn.state == NSControlStateValueOff) {
        [_mediaDeviceObjc stopCamTest];
        [_mediaDeviceObjc UnInitVideoMoudle];
        if (_testVideoView) {
            [_testVideoView removeFromSuperview];
        }
        self.testCamBtn.state = NSControlStateValueOn;
        [self.testCamBtn setTitle:@"测试摄像头"];
        
    }
    if (self.testMicBtn.state == NSControlStateValueOff) {
        [_mediaDeviceObjc stopRecordingDeviceTest];
        [_mediaDeviceObjc UnInitAudioMoudle];
        
        self.testMicBtn.state = NSControlStateValueOn;
        [self.testMicBtn setTitle:@"测试麦克风"];
    }
    if (self.testPlayBtn.state == NSControlStateValueOff) {
        [_mediaDeviceObjc stopPlaybackDeviceTest];
        
        self.testPlayBtn.state = NSControlStateValueOn;
        [self.testPlayBtn setTitle:@"测试扬声器"];
    }
    
}



/// 摄像头操作
- (IBAction)selectCamaro:(NSPopUpButton *)sender {
    NSInteger index = sender.indexOfSelectedItem;
    
    _currentCamaroIndex = (int)index;
    
}
- (IBAction)testCamaro:(NSButton *)sender {
    
    if (sender.state == NSControlStateValueOff) {
        _testVideoView = [NSView new];
        _testVideoView.frame = self.renderView.bounds;
        [self.renderView addSubview:_testVideoView];
        
        tPRTCDeviceInfo info;
        [_mediaDeviceObjc getVideoDevInfo:_currentCamaroIndex info:&info];
        
        int ret = [_mediaDeviceObjc setVideoDevice:&info];
        if (ret != 0) {
            return;
        }
        ret = [_mediaDeviceObjc startCamTest:[NSString stringWithUTF8String:info.mDeviceId] profile:(PRTC_VIDEO_PROFILE_1280_720) hwnd:(__bridge void*)_testVideoView];
        if (ret != 0) {
            return;
        }
        [sender setTitle:@"停止测试"];
                
        
    } else {
        if (_testVideoView) {
            [_testVideoView removeFromSuperview];
        }
        [_mediaDeviceObjc stopCamTest];
        [sender setTitle:@"测试摄像头"];
    }
   
    
    
}

/// 麦克风操作
- (IBAction)selectMic:(NSPopUpButton *)sender {
    _currentMicIndex = (int)sender.indexOfSelectedItem;
    

}

- (IBAction)testMic:(NSButton *)sender {
    if (sender.state == NSControlStateValueOff) {
        tPRTCDeviceInfo info;
        [_mediaDeviceObjc getRecordDevInfo:_currentMicIndex info:&info];
        [_mediaDeviceObjc setRecordDevice:&info];
        [_mediaDeviceObjc startRecordingDeviceTestWithDelegate:self];
        [sender setTitle:@"停止测试"];
    } else {
        [_mediaDeviceObjc stopRecordingDeviceTest];
        [sender setTitle:@"测试麦克风"];
    }
    
}

- (IBAction)micVolumeChange:(NSSlider *)sender {
    [_mediaDeviceObjc setRecordingDeviceVolume:(int)sender.integerValue];

}


/// 播放操作
- (IBAction)selectPlayout:(NSPopUpButton *)sender {
    
    _currentPlayoutIndex = (int)sender.indexOfSelectedItem;

}
- (IBAction)testPlayout:(NSButton *)sender {
    if (sender.state == NSControlStateValueOff) {
        tPRTCDeviceInfo info;
        [_mediaDeviceObjc getPlayoutDevInfo:_currentPlayoutIndex info:&info];
        [_mediaDeviceObjc setPlayoutDevice:&info];
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"likeu.wav" ofType:nil];
        [_mediaDeviceObjc startPlaybackDeviceTest:filepath];
        [sender setTitle:@"停止测试"];
    } else {
        [_mediaDeviceObjc stopPlaybackDeviceTest];
        [sender setTitle:@"测试扬声器"];
    }
    
}
- (IBAction)playVolumeChange:(NSSlider *)sender {
    [_mediaDeviceObjc setPlaybackDeviceVolume:(int)sender.integerValue];
}


- (void)onMicAudioLevel:(int)volume {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setProgress:volume];
    });
    

}



#pragma mark 音量

- (void)initvolumeProgressBg {
    CGFloat maxWidth = self.volumeProgressBg.bounds.size.width;
    CGFloat heigth = self.volumeProgressBg.bounds.size.height;
//    range (0, 255)  ->  255 / 5 = 51
    CGFloat itemWidth = maxWidth / (VOLUME_ITEM_COUNT * 2);
    
    for (int i = 0; i < VOLUME_ITEM_COUNT; i++) {
        CGFloat x = i * itemWidth * 2;
        NSView *line = [[NSView alloc] initWithFrame:(NSMakeRect(x, 0, itemWidth, heigth))];
        line.wantsLayer = YES;
        line.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
        line.layer.cornerRadius = itemWidth / 2;
        [self.volumeProgressBg addSubview:line];
        [_lineArray addObject:line];
    }
    
}

- (void)setProgress:(int)volume {
    int item_range = 15;

    int progress = volume / item_range;
    
    for (int i = 0; i < VOLUME_ITEM_COUNT; i ++) {
        NSView *line = _lineArray[i];

        if (i < progress) {
            line.layer.backgroundColor = [NSColor greenColor].CGColor;
        } else {
            line.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
        }
        
    }
    
    
}


@end
