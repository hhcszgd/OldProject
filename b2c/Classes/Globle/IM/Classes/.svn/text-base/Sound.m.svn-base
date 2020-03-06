//
//  Sound.m
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "Sound.h"
#import <AVFoundation/AVFoundation.h>

@implementation Sound

static AVAudioPlayer *player;

+ (void)init { 
    if (player) { 
        return;
    } 
	
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"msg" ofType:@"mp3"]; 
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
    LOG(@"_%@_%d_消息声音的地址是%@",[self class] , __LINE__,soundUrl);
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
    [player prepareToPlay]; 
}

+ (void)play { 
    if (player == nil) {
		[self init];
	}
	
    [player play];
} 

@end
