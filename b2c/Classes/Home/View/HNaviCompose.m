//
//  HNaviCompose.m
//  b2c
//
//  Created by wangyuanfei on 16/4/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HNaviCompose.h"

#import "HCellComposeModel.h"

@interface HNaviCompose ()
@property(nonatomic,weak)UIImageView  * ImageViewInNaviCompose ;
@property(nonatomic,weak)UILabel * titleLabelInNaviCompose ;
@property(nonatomic,weak)UILabel * countLabelInNaviCompose ;
@end


@implementation HNaviCompose

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIImageView * ImageViewInNaviCompose = [[UIImageView alloc]init];
        self.ImageViewInNaviCompose = ImageViewInNaviCompose ;
        [self addSubview:self.ImageViewInNaviCompose];
        
        UILabel * titleLabelInNaviCompose = [[UILabel alloc]init];
        titleLabelInNaviCompose.font = [UIFont systemFontOfSize:10*SCALE];
        titleLabelInNaviCompose.textColor  = [UIColor blackColor];
        titleLabelInNaviCompose.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabelInNaviCompose= titleLabelInNaviCompose;
        [self addSubview:self.titleLabelInNaviCompose];
        
        UILabel * countLabelInNaviCompose = [[UILabel alloc]init];
        
        countLabelInNaviCompose.textColor = [UIColor whiteColor] ;
        countLabelInNaviCompose.textAlignment = NSTextAlignmentCenter;
        countLabelInNaviCompose.font = [UIFont systemFontOfSize:8];
        countLabelInNaviCompose.backgroundColor  = [UIColor redColor];
        
        
        self.countLabelInNaviCompose = countLabelInNaviCompose;
        [self addSubview:countLabelInNaviCompose];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = 9 ;
    if (self.composeModel.title.length>0) {
        CGFloat titW = self.bounds.size.width;
        CGFloat titH = margin*2;
        CGFloat titX = 0 ;
        CGFloat titY = self.bounds.size.width-margin*2  ;
        self.titleLabelInNaviCompose.frame = CGRectMake(titX, titY, titW, titH);
        if (self.composeModel.imgForLocal) {
            CGFloat imgW = self.bounds.size.width-margin*2;
            CGFloat imgH = imgW ;
            CGFloat imgX = margin ;
            CGFloat imgY = 0 ;
            self.ImageViewInNaviCompose.frame = CGRectMake(imgX, imgY, imgW, imgH);
            
        }
        if (self.composeModel.messageCountInCompose>0 && ([self.composeModel.title  isEqualToString:@"消息"] || !self.composeModel.title)) {
            self.countLabelInNaviCompose.hidden = NO ;
            
            
            CGSize numSize= [self.countLabelInNaviCompose.text stringSizeWithFont:7+1];
            CGFloat cornerCountLabelW = 2 ;
            CGFloat cornerCountLabelH = -2  ;
            if (numSize.width>numSize.height) {
                cornerCountLabelW += numSize.width ;
                cornerCountLabelH += numSize.height ;
            }else{
                cornerCountLabelH = numSize.height;
                cornerCountLabelW = cornerCountLabelH;
                
            }
            self.countLabelInNaviCompose.bounds = CGRectMake(0, 0, 20, 20);
            self.countLabelInNaviCompose.layer.cornerRadius = cornerCountLabelH*0.5 ;
            self.countLabelInNaviCompose.layer.masksToBounds = YES;
            self.countLabelInNaviCompose.bounds =CGRectMake(0, 0, cornerCountLabelW   , cornerCountLabelH);
            self.countLabelInNaviCompose.center = CGPointMake(CGRectGetMaxX(self.ImageViewInNaviCompose.frame)+3, 3);
            
            
        }else{
            self.countLabelInNaviCompose.hidden = YES;
        }

        
    }else{
        
        if (self.composeModel.imgForLocal) {
            CGFloat imgW = self.bounds.size.width-margin*2;
            CGFloat imgH = imgW ;
            CGFloat imgX = margin ;
            CGFloat imgY = (self.bounds.size.width-imgW )/ 2 ;
            self.ImageViewInNaviCompose.image = self.composeModel.imgForLocal;
            self.ImageViewInNaviCompose.frame = CGRectMake(imgX, imgY, imgW, imgH);
            
        }
        if (self.composeModel.messageCountInCompose>0 && ([self.composeModel.title  isEqualToString:@"消息"] || !self.composeModel.title)) {
            self.countLabelInNaviCompose.hidden = NO ;
            
            
            CGSize numSize= [self.countLabelInNaviCompose.text stringSizeWithFont:7+1];
            CGFloat cornerCountLabelW = 2 ;
            CGFloat cornerCountLabelH = -2  ;
            if (numSize.width>numSize.height) {
                cornerCountLabelW += numSize.width ;
                cornerCountLabelH += numSize.height ;
            }else{
                cornerCountLabelH = numSize.height;
                cornerCountLabelW = cornerCountLabelH;
                
            }
            self.countLabelInNaviCompose.bounds = CGRectMake(0, 0, 20, 20);
            self.countLabelInNaviCompose.layer.cornerRadius = cornerCountLabelH*0.5 ;
            self.countLabelInNaviCompose.layer.masksToBounds = YES;
            self.countLabelInNaviCompose.bounds =CGRectMake(0, 0, cornerCountLabelW   , cornerCountLabelH);
            self.countLabelInNaviCompose.center = CGPointMake(CGRectGetMaxX(self.ImageViewInNaviCompose.frame), CGRectGetMinY(self.ImageViewInNaviCompose.frame));
            
            
        }else{
            self.countLabelInNaviCompose.hidden = YES;
        }
    }
   
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    
    NSInteger messageCount =  [[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
    composeModel.messageCountInCompose = messageCount;
    
    [super setComposeModel:composeModel];
    
    self.model = composeModel;
//    LOG(@"_%@_%d_%ld",[self class] , __LINE__,composeModel.messageCountInCompose);
    if (composeModel.title.length>0) {
        self.titleLabelInNaviCompose.text = composeModel.title;
    }
//    LOG(@"_%@_%d_%ld",[self class] , __LINE__,composeModel.messageCountInCompose);

    if (composeModel.messageCountInCompose==0) {
        LOG(@"_%@_%d_%ld",[self class] , __LINE__,composeModel.messageCountInCompose);
 
    }else{
        self.countLabelInNaviCompose.text = @" ";
    }
    
//    else if (composeModel.messageCountInCompose>0 && composeModel.messageCountInCompose<10) {
//
//        self.countLabelInNaviCompose.text = [NSString stringWithFormat:@"%ld",composeModel.messageCountInCompose];
//    }else if (composeModel.messageCountInCompose==10 || composeModel.messageCountInCompose>10){
//        self.countLabelInNaviCompose.text = @"9+";
//    }else{
//        LOG(@"_%@_%d_%ld",[self class] , __LINE__,composeModel.messageCountInCompose);
//    }
    if (composeModel.imgForLocal) {
        self.ImageViewInNaviCompose.image = composeModel.imgForLocal ;
    }
//    [self setNeedsDisplay];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)changeMessageCount{
    dispatch_async(dispatch_get_main_queue(), ^{
        //do your UI
        NSInteger messageCount =  [[[NSUserDefaults standardUserDefaults] objectForKey:MESSAGECOUNTCHANGED] integerValue];
        self.composeModel.messageCountInCompose = messageCount;
        
        if (messageCount<0 || messageCount==0) {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:MESSAGECOUNTCHANGED];
        }else{
                self.countLabelInNaviCompose.text = @" ";
            
        }
        
//        else if (messageCount>0 && messageCount<10) {
//            
//            self.countLabelInNaviCompose.text = [NSString stringWithFormat:@"%ld",messageCount];
//        }else if (messageCount==10 || messageCount>10){
//            self.countLabelInNaviCompose.text = @"9+";
//        }else{ }
        [self setNeedsLayout];
        [self layoutIfNeeded];
    });

}

-(void)switchBackGroundColorAndTitleColorWithSomeValue:(CGFloat)value{//红点和文字的颜色反转一下
    if (value>0.5) {
        self.countLabelInNaviCompose.textColor = [UIColor redColor] ;
//        self.countLabelInNaviCompose.backgroundColor  = [UIColor whiteColor];//不显示具体数量了,  所以也不用反转了
        
    }else{
        self.countLabelInNaviCompose.textColor = [UIColor whiteColor] ;
        self.countLabelInNaviCompose.backgroundColor  = [UIColor redColor];
    }
}

-(void)setBottomTitleColor:(UIColor *)bottomTitleColor{
    _bottomTitleColor = bottomTitleColor;
    self.titleLabelInNaviCompose.textColor = bottomTitleColor;
    self.ImageViewInNaviCompose.image = [UIImage imageNamed:@"icon_news_grey"];
}
@end
