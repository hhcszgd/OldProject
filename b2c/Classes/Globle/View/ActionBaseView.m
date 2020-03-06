//
//  ActionBaseView.m
//  b2c
//
//  Created by wangyuanfei on 3/25/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "ActionBaseView.h"

@interface ActionBaseView()
@property(nonatomic,weak)UILabel * titleLabel ;
//@property(nonatomic,weak)UIImageView * imgView ;
@property(nonatomic,weak)UIImageView * backImg ;

@end

@implementation ActionBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



/**
 //添加监听者
 [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
 
// 监听属性值发生改变时回调

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    [self alphaNavController].barAlpha = MIN(1, delta);
}
 */
-(UIImageView * )backImg{
    if(_backImg==nil){
        UIImageView * backImg =  [[UIImageView alloc]init];
//        backImg.contentMode = UIViewContentModeScaleAspectFill;
        _backImg = backImg;
//        backImg.frame = self.bounds;
        [self addSubview:backImg];
    }
    return _backImg;
}




-(UILabel * )titleLabel{
    if(_titleLabel==nil && _title){
        UILabel * titleLabel = [[UILabel alloc]init];
        _titleLabel = titleLabel;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [self addSubview:titleLabel];
    }
    return _titleLabel;
}

//-(UIImageView * )imgView{
//    if(_imgView==nil && _img){
//        UIImageView * imgView= [[UIImageView alloc]init];
//        [self addSubview:imgView];
//        _imgView = imgView;
//    }
//    return _imgView;
//}
-(void)layoutSubviews{
    [super layoutSubviews];
    
//    if (self.subviews.count>2) {
//        
//    }else{
//        if (self.titleLabel) {
//            self.titleLabel.frame = self.bounds;
//        }
//        if (self.imgView) {
//            self.imgView.frame = self.bounds;
//        }
//    }

    if (self.backImageURLStr.length>0 ) {
        if ([self.backImageURLStr hasPrefix:@"http"]) {
            [self.backImg sd_setImageWithURL:[NSURL URLWithString:self.backImageURLStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        }else{
            
            [self.backImg sd_setImageWithURL:ImageUrlWithString(self.backImageURLStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        }
        self.backImg.frame = self.bounds;
    }
    if (self.backImageURL) {
        self.backImg.frame = self.bounds;
    }
    if (self.img) {
        self.backImg.image = self.img;
        self.backImg.frame = self.bounds;
    }

}
//-(void)setTitle:(NSString *)title{
//    _title = title;
//    self.titleLabel.text = title;
//}

-(void)setImg:(UIImage *)img{
    _img = img;
    self.backImg.image = img;
}
-(void)setBackImageURLStr:(NSString *)backImageURLStr{
    _backImageURLStr = backImageURLStr ;
    if (self.backImageURLStr.length>0) {
        if ([self.backImageURLStr hasPrefix:@"http"]) {
            [self.backImg sd_setImageWithURL:[NSURL URLWithString:backImageURLStr] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        }else{
//            if ([self.backImageURLStr hasPrefix:@"/"]) {
//                self.backImageURLStr = [self.backImageURLStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
//            }
            [self.backImg sd_setImageWithURL:ImageUrlWithString(self.backImageURLStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        }
        self.backImg.frame = self.bounds;
    }else{
        self.backImg.image = nil;
    }

}

-(void)setBackImageURL:(NSURL *)backImageURL{
    _backImageURL = backImageURL;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,backImageURL);
    if (backImageURL) {
        [self.backImg sd_setImageWithURL:backImageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        self.backImg.frame = self.bounds;
    }else{
        self.backImg.image = nil;
    }

//    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.backImg);
}

-(void)setModel:(BaseModel *)model{
    _model = model;
    self.title = model.title;

}
@end
