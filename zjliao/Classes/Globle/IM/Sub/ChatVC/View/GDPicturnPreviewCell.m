//
//
//  b2c
//
//  Created by WY on 17/2/16.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import "GDPicturnPreviewCell.h"
#import <Photos/Photos.h>

#import "zjlao-Swift.h"

@interface GDPicturnPreviewCell()<UIGestureRecognizerDelegate , UIScrollViewDelegate , UIAlertViewDelegate>
@property(nonatomic,weak)UIScrollView * scrollView ;
@property(nonatomic,assign)BOOL  saveToPhotoIsShow ;
@property(nonatomic,weak)UIImageView * imgView ;

@end


@implementation GDPicturnPreviewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setupScrollView];
        [self setupImageView];

    }
    return self;
}

-(void)setupImageView
{
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imgView = imgView;
    imgView.contentMode = UIViewContentModeScaleAspectFit ;
    [self.scrollView addSubview:imgView];
}
-(void )setupScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];//此时bounds为ling
    self.scrollView = scrollView;
    [self.contentView  addSubview:scrollView];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self  action:@selector(longPress:)];
    [scrollView addGestureRecognizer:longPress];
    
    UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(oneTap:) ];
    [self.scrollView addGestureRecognizer:oneTap];

    
    
    UITapGestureRecognizer * twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(twoTap:) ];
    twoTap.numberOfTapsRequired = 2 ;//点击次数
    //        twoTap.numberOfTouchesRequired = 1 ;//手指数
    
    //        imgView.gestureRecognizers = @[  twoTap];
    //        twoTap.allo
    [scrollView addGestureRecognizer:twoTap];
    [oneTap requireGestureRecognizerToFail:twoTap];  //加入这一行就不会出现这个问题//注意 ,放在两个手势都添加到视图以后调用
  //  CGSize imgSize = self.imgView.image.size ;
   // CGFloat imageW = imgSize.width;
   // CGFloat imageH = imgSize.height;
    //self.scrollView.contentSize=CGSizeMake(imageW, imageH);
    
    //3.2 设置UIScrollView的4周增加额外的滚动区域
  //  CGFloat distance = 100.0f;
    //self.scrollView.contentInset = UIEdgeInsetsMake(distance, distance, distance, distance);
    
    //3.3 设置弹簧效果
    self.scrollView.bounces = YES;
    self.scrollView.backgroundColor = [UIColor darkGrayColor];
    
    //3.4 设置滚动不显示
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    //6 设置代理
    self.scrollView.delegate = self;
    //self.scrollView.contentMode = UIViewContentModeCenter;
    
    //7 缩放
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=2.0f;
    /*
  @property(nonatomic) CGFloat zoomScale NS_AVAILABLE_IOS(3_0);            // default is 1.0
  - (void)setZoomScale:(CGFloat)scale animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);
  - (void)zoomToRect:(CGRect)rect animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);
  */
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    return  YES ;
//}




-(void)setImg:(UIImage *)img{
    _img = img;
    self.imgView.image  =  img ;
    self.scrollView.frame = self.bounds;
    self.imgView.bounds = CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height / 2 , 0, 0);
    self.imgView.center = self.scrollView.center;
    self.alpha = 0.01;

    
    CGSize imgSize = self.imgView.image.size ;
    CGFloat imgW = 0 ;
    CGFloat imgH = 0 ;
    if ( imgSize.width > [UIScreen mainScreen].bounds.size.width && imgSize.height > [UIScreen mainScreen].bounds.size.height ) {//宽高都在屏幕以外
        //假设宽就是屏幕的宽  //那么高等于
        CGFloat tempW = [UIScreen mainScreen].bounds.size.width;
        CGFloat tempH = imgSize.height * tempW/imgSize.width;
        if (tempH > [UIScreen mainScreen].bounds.size.height) {
            imgH = [UIScreen mainScreen].bounds.size.height;
            imgW = [UIScreen mainScreen].bounds.size.height * imgSize.width/imgSize.height;
        }else{//就这样
            imgW = tempW;
            imgH = tempH;
        }
      
    }else if ( imgSize.width > [UIScreen mainScreen].bounds.size.width && imgSize.height < [UIScreen mainScreen].bounds.size.height ){//宽在屏幕以外 , 高在屏幕以内
        imgW = [UIScreen mainScreen].bounds.size.width ;
        imgH = imgSize.height * [UIScreen mainScreen].bounds.size.width/imgSize.width;
    }else if (imgSize.width < [UIScreen mainScreen].bounds.size.width && imgSize.height > [UIScreen mainScreen].bounds.size.height ){//宽在屏幕以内 , 高在屏幕以外
        imgH = [UIScreen mainScreen].bounds.size.height;
        imgW = [UIScreen mainScreen].bounds.size.height * imgSize.width/imgSize.height;
    }else if (imgSize.width < [UIScreen mainScreen].bounds.size.width && imgSize.height < [UIScreen mainScreen].bounds.size.height){//宽高都在屏幕以内  , 让较比例后的长边充满屏幕
        
        imgW = imgSize.width;
        imgH = imgSize.height;
    }
    
    
    
    //self.scrollView.contentSize = CGSizeMake(imgW, imgH);
    
    
    
     NSLog(@"_%d_%@",__LINE__,NSStringFromCGSize(CGSizeMake(imgW, imgH)));
    
    [UIView animateWithDuration:0.2 animations:^{
        //self.imgView.frame = CGRectMake((screenW - imgW )/2 , (screenH - imgH) /2  , imgW, imgH );
        self.imgView.bounds = CGRectMake(0 , 0  , imgW, imgH );
        self.imgView.center = self.scrollView.center;
        
        self.alpha = 1.0;
    }];
    //[self.scrollView setContentOffset:CGPointMake(0,  -(screenH - imgH) /2) animated:NO];
     NSLog(@"_%d_%@",__LINE__,NSStringFromCGRect(self.scrollView.frame));
     NSLog(@"_%d_%@",__LINE__,NSStringFromCGRect(self.imgView.frame));
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}



#pragma mark 代理方法
// 用户开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"开始拖拽");
}
// 滚动到某个位置时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"拖拽中");
}
// 用户结束拖拽时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"结束拖拽");
}
#pragma mark 缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
     NSLog(@"_%d_%@",__LINE__,self.imgView);
    NSLog(@"开始缩放");
    return self.imgView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"正在缩放");
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
 
    //[self.imgView convert]
    /*
    
    NSInteger num =  scrollView.pinchGestureRecognizer.numberOfTouches;
    
     //NSLog(@"_%d_%ld",__LINE__,(long)num);
    
    CGPoint point1 =  [scrollView.pinchGestureRecognizer locationOfTouch:0 inView:scrollView];
    CGPoint point2 =  [scrollView.pinchGestureRecognizer locationOfTouch:1 inView:scrollView];

     NSLog(@"_%d_%@",__LINE__,NSStringFromCGPoint(point1));
    NSLog(@"_%d_%@",__LINE__,NSStringFromCGPoint(point2));
*/
    NSLog(@"缩放结束");
     NSLog(@"_%d_%@",__LINE__,NSStringFromCGRect(self.imgView.frame));
    
    CGRect frame = self.imgView.frame;
    
    frame.origin.y = (self.scrollView.frame.size.height - self.imgView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.imgView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.imgView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.imgView.frame.size.width) * 0.5 : 0;
     NSLog(@"_%d_%@",__LINE__,NSStringFromCGPoint(frame.origin));
    [UIView animateWithDuration:0.18 animations:^{
        self.imgView.frame = frame;
        self.scrollView.contentSize = CGSizeMake(self.imgView.frame.size.width , self.imgView.frame.size.height);
        
    }];
    
}



-(void)oneTap:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.imgView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 , [UIScreen mainScreen].bounds.size.height/2,0, 0);
        self.alpha = 0.01;
    }completion:^(BOOL finished) {
        
        if ([self.delegate  respondsToSelector:@selector(oneTapOnView:)]) {
            [self.delegate oneTapOnView:self ];
        }
    }];
    
    NSLog(@"点一下_%d_%@",__LINE__,sender);
}


-(void )longPress:(UILongPressGestureRecognizer*)sender
{
    if (!self.saveToPhotoIsShow) {
        self.saveToPhotoIsShow = YES ;
        //执行弹出保存至相册
        //保存完毕后self.saveToPhotoIsShow = NO;
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil  message:@"保存至相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定" , nil ];
        [alertView show];
    }
}

-(void)twoTap:(UITapGestureRecognizer *)sender
{

     NSLog(@"_%d_%@",__LINE__,@"点两下");
    if (self.scrollView.zoomScale == 1 ) {
        [self.scrollView setZoomScale:2 animated:YES];
    }else{
        [self.scrollView setZoomScale:1 animated:YES];
    }
}
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
//    GDlog(@"%ld",buttonIndex)
    self.saveToPhotoIsShow = NO ;
    if(buttonIndex == 0){//取消
        
    }else if (buttonIndex == 1 ){//确定
        //        UIImageWriteToSavedPhotosAlbum(self.img, self , @selector(saveImgComplite), nil );
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            //写入图片到相册
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:self.img];
            
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if(success){
                //                dispatch_async(dispatch_get_main_queue(), ^{
                
                //                    AlertInSubview(@"保存成功")
                //                });
                [GDAlertView alert:@"保存成功" image:nil  time:3  complateBlock:^{}];
                
            }else{
                //                dispatch_async(dispatch_get_main_queue(), ^{
                //
                //                    AlertInSubview(@"保存失败")
                //                });
                [GDAlertView alert:@"保存失败" image:nil  time:3  complateBlock:^{}];
                
            }
            NSLog(@"success = %d, error = %@", success, error);
            
        }];
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView {
    
//    GDlog(@"点击了取消")
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    GDlog(@"消失")
    self.saveToPhotoIsShow = NO ;
}







/*
 imgView.userInteractionEnabled = YES;
 UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(oneTap:) ];
 oneTap.delegate  =self ;
 [scrollView addGestureRecognizer:oneTap];
 
 UITapGestureRecognizer * twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(twoTap:) ];
 twoTap.numberOfTapsRequired = 2 ;//点击次数
 //        twoTap.numberOfTouchesRequired = 1 ;//手指数
 
 //        imgView.gestureRecognizers = @[  twoTap];
 //        twoTap.allo
 [scrollView addGestureRecognizer:twoTap];
 [oneTap requireGestureRecognizerToFail:twoTap];  //加入这一行就不会出现这个问题//注意 ,放在两个手势都添加到视图以后调用
 UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self  action:@selector(longPress:)];
 [scrollView addGestureRecognizer:longPress];
 
 UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self  action:@selector(pinchGesture:)];
 [scrollView addGestureRecognizer:pinchGesture];
 self.isScaled = NO ;
 */
/*
 UIPinchGestureRecognizer（捏合）
 UILongPressGestureRecognizer（长按）
 */

/*
 -(void )longPress:(UILongPressGestureRecognizer*)sender
 {
 if (!self.saveToPhotoIsShow) {
 self.saveToPhotoIsShow = YES ;
 //执行弹出保存至相册
 //保存完毕后self.saveToPhotoIsShow = NO;
 }
 NSLog(@"_%d_%@",__LINE__,@"长按");
 }
 -(void)oneTap:(UITapGestureRecognizer *)sender
 {
 [UIView animateWithDuration:0.2 animations:^{
 self.imgView.frame = CGRectMake(screenW/2 , screenH/2,0, 0);
 self.alpha = 0.01;
 }completion:^(BOOL finished) {
 
 if ([self.delegate  respondsToSelector:@selector(oneTapOnView:)]) {
 [self.delegate oneTapOnView:self ];
 }
 }];
 
 NSLog(@"点一下_%d_%@",__LINE__,sender);
 }
 -(void )pinchGesture:(UIPinchGestureRecognizer*)sender
 {
 NSLog(@"_%d_%@",__LINE__,@"捏合");
 NSLog(@"_%d_%@",__LINE__,NSStringFromCGRect(self.imgView.frame));
 NSLog(@"_%d_%f",__LINE__,sender.scale);
 NSLog(@"_%d_%f",__LINE__,self.imgView.transform.a);
 CGFloat  scaledH =   screenH * sender.scale ;
 CGFloat  scaledW =  screenW * sender.scale ;
 CGSize size = self.scrollView.contentSize ;
 switch (sender.state) {
 case UIGestureRecognizerStateBegan:
 break;
 case UIGestureRecognizerStateChanged:
 //            self.imgView.frame = CGRectMake(-scaledW/2, -scaledH/2,scaledW ,  scaledH);
 
 //            self.scrollView.contentSize = CGSizeMake(1000, 2000);
 
 self.imgView.transform = CGAffineTransformMakeScale(sender.scale + self.priviousScale, sender.scale+self.priviousScale);
 //self.currentScale = self.priviousScale + sender.scale;
 break;
 case UIGestureRecognizerStateEnded:
 break;
 default:
 break;
 }
 }
 -(void)twoTap:(UITapGestureRecognizer *)sender
 {
 //- (CGPoint)locationInView:(nullable UIView*)view;
 CGPoint pointInScrollVier = [sender locationInView:self.scrollView]; // 屏幕的三分之一 和三分之二为分割
 NSLog(@"_%d_%@",__LINE__,NSStringFromCGPoint(pointInScrollVier));
 NSLog(@"点两下_%d_%@",__LINE__,sender);
 CGSize imgSize = self.imgView.image.size ;
 if ( imgSize.width > screenW && imgSize.height > screenH ) {//宽高都在屏幕以外
 if (self.imgView.bounds.size.width>screenW || self.imgView.bounds.size.height > screenH) {//图片出于放大状态 , 执行恢复屏宽
 self.scrollView.contentSize = CGSizeMake(screenW, screenH) ;
 //    self.scrollView.contentOffset = CGPointMake(100, 100);
 [UIView animateWithDuration:0.2 animations:^{
 //self.imgView.frame = CGRectMake(0, 0, screenW, screenH);
 self.transform = CGAffineTransformMakeScale(1, 1);
 }];
 }else{//图片属于原始状态//执行放大操作
 self.scrollView.contentSize = imgSize ;
 //    self.scrollView.contentOffset = CGPointMake(100, 100);
 [UIView animateWithDuration:0.2 animations:^{
 //self.imgView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
 self.transform = CGAffineTransformMakeScale(2, 2);
 }completion:^(BOOL finished) {
 NSLog(@"_%d_%@",__LINE__,NSStringFromCGRect(_imgView.bounds));
 
 }];
 
 }
 
 
 NSLog(@"_%d_%f",__LINE__,self.imgView.transform.a);
 
 if (self.isScaled) {
 self.transform = CGAffineTransformMakeScale(1, 1);
 self.priviousScale = 0 ;
 self.isScaled = NO;
 }else{
 
 self.transform = CGAffineTransformMakeScale(2, 2);
 self.priviousScale = 1 ;
 self.isScaled = YES ;
 }
 

}else if ( imgSize.width > screenW && imgSize.height < screenH ){//宽在屏幕以外 , 高在屏幕以内
    if (self.imgView.bounds.size.width>screenW || self.imgView.bounds.size.height > screenH) {//图片出于放大状态 , 执行回复屏宽
        
    }else{//图片属于原始状态//执行放大操作
        
    }
    
}else if (imgSize.width < screenW && imgSize.height > screenH ){//宽在屏幕以内 , 高在屏幕以外
    if (self.imgView.bounds.size.width>screenW || self.imgView.bounds.size.height > screenH) {//图片出于放大状态 , 执行回复屏宽
        
    }else{//图片属于原始状态//执行放大操作
        
    }
    
}else if (imgSize.width < screenW && imgSize.height < screenH){//宽高都在屏幕以内  , 让较比例后的长边充满屏幕
    NSLog(@"_%d_%@",__LINE__,@"宽高都在屏幕内");
}

//    if (imgSize.width > imgSize.height) {//宽大些
//        if (imgSize.width >= screenW) {//可缩放
//            if (self.imgView.bounds.size.width>screenW) {
//
//            }
//
//        }else{//原图显示
//
//        }
//    }else{//高大些
//        if (imgSize.height >= screenH) {//可缩放
//
//        }else{//原图显示
//
//        }
//    }
}
 */

@end
