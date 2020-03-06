//
//  MsgSound.m
//  IOSCim
//
//  Created by apple apple on 11-6-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "MsgSound.h"
#import <AVFoundation/AVFoundation.h>

@implementation MsgSound

static AVAudioPlayer *player;

+ (id)init 
{ 
    if (player == nil) 
	{ 
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"msg" ofType:@"mp3"]; 
        NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath]; 
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
        [player prepareToPlay]; 
        //  [soundUrl release]; 
    } 
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
