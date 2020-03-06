//
//  OnlineSound.m
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "OnlineSound.h"
#import <AVFoundation/AVFoundation.h>

@implementation OnlineSound

static AVAudioPlayer *player;

+ (id)init
{ 
    if (player)
	{ 
        return nil;
    } 
	
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"global" ofType:@"mp3"]; 
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
    LOG(@"_%@_%d_消息的地址是%@",[self class] , __LINE__,soundUrl);
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
    [player prepareToPlay];
	return nil;
}



+ (void)play 
{ 
    if (player == nil) 
	{
		[self init];
	}
	
    [player play];
} 


@end
