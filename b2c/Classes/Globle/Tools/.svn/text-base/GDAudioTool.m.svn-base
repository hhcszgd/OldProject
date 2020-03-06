//
//  GDAudioPlayer.m
//  b2c
//
//  Created by wangyuanfei on 16/6/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
/**
 // 加载自定义名称为Resources.bundle中对应images文件夹中的图片
 // 思路:从mainbundle中获取resources.bundle
 NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@”Resources” ofType:@”bundle”];
 // 找到对应images夹下的图片
 NSString *strC = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@”C” ofType:@”png” inDirectory:@”images”];
 UIImage *imgC = [UIImage imageWithContentsOfFile:strC];
 [_imageCustomBundle setImage:imgC];
 */
#import "GDAudioTool.h"

@interface GDAudioTool ()

//@property(nonatomic,strong)AVAudioPlayer * player ;

@end

@implementation GDAudioTool
static GDAudioTool * audioTool = nil ;

+(instancetype)sharAudioTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioTool = [[GDAudioTool alloc]init];
    });
    return audioTool;
}


-(AVAudioPlayer * )player{
    if(_player==nil){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
        NSBundle * subBundel = [NSBundle bundleWithPath:path];
        NSString * soundPath = [subBundel pathForResource:@"didi" ofType:@"mp3" inDirectory:@"Sound"];
        NSURL * u = [[NSURL alloc]initFileURLWithPath:soundPath];
        NSError * error = [[NSError alloc]init];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:u error:&error];
        //        audioTool.player = _player;
    }
    return _player;
}

@end
