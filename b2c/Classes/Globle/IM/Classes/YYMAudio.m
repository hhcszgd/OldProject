//
//  YYMAudio.m
//  IOSCim
//
//  Created by apple apple on 11-8-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "YYMAudio.h"
#import <AVFoundation/AVFoundation.h>


@implementation YYMAudio


- (id)init:(NSString*)audioFileName audioFileType:(NSString*)audioFileType
{ 	
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:audioFileName ofType:audioFileType]; 
    NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath]; 
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil]; 
    [player prepareToPlay]; 
//    [soundUrl release];
//	[soundPath release];
	return self;
}



- (void)play 
{ 
    [player play];
} 


//震动
- (void)playShock
{
	//AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


@end
