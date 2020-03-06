//
//  AsynImageView.h
//  AsynImage
//
//  Created by administrator on 13-3-5.
//  Copyright (c) 2013年 enuola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"

//load图片中心计算方式
typedef NS_ENUM(NSInteger, X9AsynCenterType) {
    X9AsynCenterTypeFrame = 0,
    X9AsynCenterTypePosition = 1
};

@interface AsynImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *loadData;
    UILabel *progressLabel;
    NSNumber *imgSize;
    UIImageView *loadingImageView;
}
//图片对应的缓存在沙河中的路径
@property (nonatomic, retain) NSString *fileName;
//指定默认未加载时，显示的默认图片
@property (nonatomic, retain) UIImage *placeholderImage;
//请求网络图片的URL
@property (nonatomic, retain) NSString *imageURL;
//图片加载完毕后的回调函数
@property (nonatomic, copy) void(^loadedAfterFun)(id);
//代理
@property (nonatomic, retain) id delegate;
//设置是否需要变灰
@property (nonatomic, assign) BOOL isGrayImage;
- (id)initWithFrame:(CGRect)frame asynCenterType:(X9AsynCenterType)asynCenterType;
- (void)dontShowBorder;
@end

@protocol AsynImageViewTouchDelegate

- (void)touchBegin:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end