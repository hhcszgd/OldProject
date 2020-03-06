//
//  GCollectionCell.m
//  b2c
//
//  Created by 0 on 16/4/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "GCollectionCell.h"
#import "HStoreAptitudeModel.h"
@interface GCollectionCell()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
/**底层滑动视图*/
@property (nonatomic, strong) UIScrollView *animalScro;
/**cell中的主要图片*/
@property (nonatomic, strong) UIImageView *mainImageView;
/**是否放大*/
@property (nonatomic, assign) BOOL isBig;
/**图片大小*/
@property (nonatomic, assign) CGSize size;
@end


@implementation GCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isBig = NO;
        _animalScro = [[UIScrollView alloc] init];
        [self.contentView addSubview:_animalScro];
        _animalScro.delegate = self;
        _animalScro.userInteractionEnabled = YES;
        _animalScro.scrollEnabled = YES;
        CGFloat porpert = screenH * 1.0/screenW;
        _animalScro.maximumZoomScale = porpert *1.1;
        _animalScro.minimumZoomScale =   0.7;
        _animalScro.center =self.contentView.center;
        _animalScro.bounds = CGRectMake(0, 0, screenW, screenH);
        _animalScro.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (UIImageView *)mainImageView{
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mainImageView.frame = CGRectMake(0, 0, screenW, screenH);
        _mainImageView.userInteractionEnabled = YES;
        //单击手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [_mainImageView addGestureRecognizer:singleTap];
        singleTap.numberOfTapsRequired = 1;
        //双击手手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        [_mainImageView addGestureRecognizer:doubleTap];
        doubleTap.delegate =self;
        doubleTap.numberOfTapsRequired = 2;
        //双击手势不行的时候用单机手势
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [_animalScro addSubview:_mainImageView];
    }
    return _mainImageView;
}



- (void)setModel:(id)model{
    _isBig = NO;
    
    HStoreAptitudeModel *aptitudeModel = model;
    NSURL *url = ImageUrlWithString(aptitudeModel.image);
    [self.mainImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
    
    _animalScro.frame = CGRectMake(0, 0, screenW, screenH);
    _animalScro.contentSize = CGSizeMake(screenW, screenH);
    self.mainImageView.frame = CGRectMake(0, 0, screenW, screenH);
    
    
}

- (void)singleTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(singleAction)]) {
        [self.delegate performSelector:@selector(singleAction)];
    }
}
- (void)doubleTap:(UITapGestureRecognizer *)tap{
    
    
    if (!_isBig) {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.mainImageView.frame = CGRectMake(0, 0, _animalScro.maximumZoomScale * screenW, screenH * _animalScro.maximumZoomScale);
            _animalScro.contentSize = CGSizeMake(self.mainImageView.bounds.size.width, self.mainImageView.bounds.size.height);
        }];
        
        
        _isBig = YES;
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _animalScro.frame = CGRectMake(0, 0, screenW, screenH);
            
            self.mainImageView.frame = CGRectMake(0, 0, screenW, screenH);
            _animalScro.contentSize = CGSizeMake(screenW, screenH);
        }];
        
        _isBig = NO;
    }
    
    
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.mainImageView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}



- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    //正在缩放过程中
    //手势太快的话会出现图片超出了变大的范围
    //    if ((_image.frame.size.width > _animalScrol.maximumZoomScale * screenW) && (_image.frame.size.width > _animalScrol.maximumZoomScale * screenW)) {
    //        LOG(@"%@,%d,%@",[self class], __LINE__,@"哈哈")
    //        _animalScrol.center = self.center;
    //        _animalScrol.bounds = CGRectMake(0, 0, screenW, screenH);
    //        _image.frame = CGRectMake(0, 0, _animalScrol.maximumZoomScale * screenW, _animalScrol.maximumZoomScale * screenW);
    //        _animalScrol.contentSize = CGSizeMake(_image.frame.size.width, _image.frame.size.height);
    //    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    //结束缩放
    //如果是缩小
    if ((view.frame.size.width < screenW)&& (view.frame.size.height < screenH)) {
        _animalScro.center = self.contentView.center;
        _animalScro.bounds = CGRectMake(0, 0, screenW, screenH);
        [UIView animateWithDuration:0.2 animations:^{
            view.frame = CGRectMake(0, 0, screenW, screenH);
        }];
    }
    if ((view.frame.size.width > screenW) && (view.frame.size.height > screenH)) {
        _animalScro.center = self.contentView.center;
        _animalScro.bounds = CGRectMake(0, 0, screenW, screenH);
        _animalScro.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height);
        
        _isBig = YES;
    }
    _animalScro.center = self.contentView.center;
    
    
}

@end
