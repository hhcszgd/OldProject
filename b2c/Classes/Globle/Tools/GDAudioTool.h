//
//  GDAudioPlayer.h
//  b2c
//
//  Created by wangyuanfei on 16/6/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface GDAudioTool : NSObject
@property(nonatomic,strong)AVAudioPlayer * player ;

+(instancetype)sharAudioTool;
@end
