//
//  CZQRView.m
//  03-二维码扫描简单界面
//
//  Created by  on .
//  Copyright (c)  . All rights reserved.
//

#import "CZQRView.h"
#import <AVFoundation/AVFoundation.h>
/**
 *  具备二维码扫描的功能
 */
@interface CZQRView () <AVCaptureMetadataOutputObjectsDelegate>

/**
 *  背景框
 */
@property (nonatomic, weak) UIImageView *bgView;
/**
 *  线
 */
@property (nonatomic, weak) UIImageView *lineView;

/**
 *  session
 */

@property (nonatomic, strong) AVCaptureSession *session;


@end


@implementation CZQRView

/**
 *  设置CZQRView的layer是AVCaptureVideoPreviewLayer
 */
+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

/**
 *  使用纯代码创建View时候会调用该方法
 */
- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

/**
 *使用storyboard或xib创建View时候会调用该方法
 */
- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void) setUp
{
    UIImageView *bgView = [[UIImageView alloc] init];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UIImageView *lineView = [[UIImageView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    
//  设置数据
    self.bgView.image = [UIImage imageNamed:@"pick_bg"];
    self.lineView.image = [UIImage imageNamed:@"line"];
    
    [self configQR];
}

/**
 *  配置解析二维码
 */
- (void) configQR
{
//  创建输入对象
//  默认是后置摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(error){
        NSLog(@"%@",error);
        return;
    }
    
//  创建输出设备
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
//  创建session
    self.session = [[AVCaptureSession alloc] init];
//  连接设备
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    
//  设置输出对象的元数据类型
    output.metadataObjectTypes = output.availableMetadataObjectTypes;
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
   AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    layer.session = self.session;
    
// 开始运行session
    [self.session startRunning];
}

/**
 *  当输出对象解析到相应地内容的时候,就会调用该方法
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    AVMetadataMachineReadableCodeObject *obj = [metadataObjects firstObject];
    
    if (obj.stringValue.length != 0) {
        if ([self.delegate respondsToSelector:@selector(qrView:didCompletedWithQRValue:)]) {
            [self.delegate qrView:self didCompletedWithQRValue:obj.stringValue];
        }
        [self.session stopRunning];
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    CGFloat bgW = 200;
    CGFloat bgH = 200;
    CGFloat bgX = (size.width - bgW) * 0.5;
    CGFloat bgY = (size.height - bgH) * 0.5;
//  背景的位置
    self.bgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
//  线的frame
    self.lineView.frame = CGRectMake(bgX, bgY, bgW, 2);
    
//  使用核心动画
    [self.lineView.layer removeAnimationForKey:@"positionAnimation"];

    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    
    positionAnimation.fromValue = @(bgY);
    
    positionAnimation.toValue = @(CGRectGetMaxY(self.bgView.frame));
    
    positionAnimation.duration = 2;
    
    positionAnimation.repeatCount = NSIntegerMax;
    
    [self.lineView.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
}


@end
