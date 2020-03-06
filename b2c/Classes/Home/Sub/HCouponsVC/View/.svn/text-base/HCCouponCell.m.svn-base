//
//  HCCouponCell.m
//  b2c
//
//  Created by wangyuanfei on 16/5/4.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCCouponCell.h"

#import "HCCouponModel.h"

#import "HCellBaseComposeView.h"
#import "HCCouponcellCompose.h"

@interface HCCouponCell()

@property(nonatomic,weak)HCellBaseComposeView * leftContainer ;
@property(nonatomic,weak)HCellBaseComposeView * rightContainer ;
@property(nonatomic,weak)UIImageView * midLine ;
////////////////////
@property(nonatomic,weak)UILabel * price ;
@property(nonatomic,weak)UILabel * shopName  ;
@property(nonatomic,weak)UILabel * time ;

@property(nonatomic,weak)UILabel * limit ;
@property(nonatomic,weak)UILabel * getLabel ;
//@property(nonatomic,weak)HCCouponcellCompose * getClick ;
@property(nonatomic,weak)HCCouponcellCompose * shareClick ;
@property(nonatomic,weak)UIView * container ;

@property(nonatomic,weak)UIImageView * leftImageView ;

@property(nonatomic,weak)UIImageView * hasGotImageView ;

@end


@implementation HCCouponCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * container = [[UIView alloc]init];
        //        container.backgroundColor = randomColor;
        self.container = container;
        [self.contentView addSubview:container];
        
        
        
        
        
        HCellBaseComposeView *  rightContainer = [[HCellBaseComposeView alloc]init];
        self.rightContainer =  rightContainer ;
        [self.container addSubview:self.rightContainer];
        self.rightContainer.backgroundColor=[UIColor colorWithRed:37/256.0 green:129/256.0 blue:230/256.0 alpha:1];
        
        
        HCellBaseComposeView * leftContainer = [[HCellBaseComposeView alloc]init];
        [leftContainer addTarget:self action:@selector(leftComposeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftContainer = leftContainer ;
        [self.container addSubview:self.leftContainer];
        self.leftContainer.backgroundColor=[self.rightContainer.backgroundColor colorWithAlphaComponent:0.7];
        
        UIImageView * midLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon_rec_nor"]];
        self.midLine = midLine;
        [self.container addSubview:self.midLine];
        
        //加
        UIImageView * hasGotImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon_ydraw_nor"]];
        self.hasGotImageView  = hasGotImageView;
        [self.container addSubview:hasGotImageView];
        //加
        UIImageView * leftImageView = [[UIImageView alloc]init];
        self.leftImageView = leftImageView ;
        [self.leftContainer addSubview:leftImageView];
        leftImageView.backgroundColor = [UIColor whiteColor];

        
        UILabel * price =[[UILabel alloc]init];
        price.textColor = [UIColor whiteColor];
//        price.textAlignment = NSTextAlignmentCenter;
        self.price = price;
        [self.leftContainer addSubview:self.price];
        //        self.price.backgroundColor=  randomColor;
        
        UILabel * shopName =[[UILabel alloc]init] ;
        shopName.font = [UIFont systemFontOfSize:12*SCALE];
        self.shopName = shopName;
        shopName.textColor = [UIColor whiteColor];
        [self.leftContainer addSubview:self.shopName];
        //        self.shopName.backgroundColor=  randomColor;
//        shopName.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel * time =[[UILabel alloc]init];
        self.time = time;
        time.font = [UIFont systemFontOfSize:9*SCALE];
        time.textColor = [UIColor whiteColor];
        [self.leftContainer addSubview:self.time];
        //        self.time.backgroundColor=  randomColor;
//        time.textAlignment = NSTextAlignmentCenter;
        
        UILabel * limit =[[UILabel alloc]init];
        self.limit = limit;
        limit.font = [UIFont systemFontOfSize:11*SCALE];
        limit.textColor = [UIColor whiteColor];
        limit.numberOfLines = 2;
        [self.rightContainer addSubview:self.limit];
        //        self.limit.backgroundColor=  randomColor;
        limit.textAlignment = NSTextAlignmentCenter;
        
        
        UILabel * getLabel =[[UILabel alloc]init];
        self.getLabel = getLabel;
        getLabel.textColor = [UIColor whiteColor];
        [self.rightContainer addSubview:self.getLabel];
        //        self.getLabel.backgroundColor=  randomColor;
        getLabel.textAlignment = NSTextAlignmentCenter;
        
        
        HCCouponcellCompose * getClick =[[HCCouponcellCompose alloc]initWithFrame:CGRectZero andToBorderMargin:10];
        self.getClick = getClick;
        getClick.topImage = [UIImage imageNamed:@"bg_icon_draw_sel"];
        getClick.bottomTitle = @"领取";
        getClick.bottomTitleColor = [UIColor yellowColor];
        [self.rightContainer addSubview:self.getClick];
        [getClick addTarget:self action:@selector(gotComposeClick:) forControlEvents:UIControlEventTouchUpInside];
//        [getClick setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [getClick.titleLabel setFont:[UIFont systemFontOfSize:12*SCALE]];
        getClick.bottomTitleFont = [UIFont systemFontOfSize:11];
        
//        self.getClick.backgroundColor = [UIColor colorWithRed:251/256.0 green:195/256.0 blue:33/256.0 alpha:1];


        HCCouponcellCompose * shareClick =[[HCCouponcellCompose alloc]initWithFrame:CGRectZero andToBorderMargin:10];
        self.shareClick = shareClick;
        shareClick.topImage = [UIImage imageNamed:@"bg_icon_share_nor"];
        shareClick.bottomTitle = @"分享";
        shareClick.bottomTitleColor = [UIColor whiteColor];
        [self.rightContainer addSubview:self.shareClick];
        [shareClick addTarget:self action:@selector(shareComposeClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [getClick setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [getClick.titleLabel setFont:[UIFont systemFontOfSize:12*SCALE]];
        shareClick.bottomTitleFont = [UIFont systemFontOfSize:11];
        
//        self.shareClick.backgroundColor = [UIColor colorWithRed:251/256.0 green:195/256.0 blue:33/256.0 alpha:1];

        
        
    }
    return self;
}
-(void)gotComposeClick:(HCCouponcellCompose*)sender
{
    if (self.couponModel.take) {
        return;
    }
//    if ([self.CouponCellDelegate respondsToSelector:@selector(clickActionInCellCompose:withActionType:)]) {
//        [self.CouponCellDelegate clickActionInCellCompose:sender withActionType:GotTicket];
//    }
    if ([self.CouponCellDelegate respondsToSelector:@selector(clickActionInCell:withActionType:)]) {
        [self.CouponCellDelegate clickActionInCell:self withActionType:GotTicket];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击领取");
}
-(void)shareComposeClick:(ActionBaseView*)sender
{
    if ([self.CouponCellDelegate respondsToSelector:@selector(clickActionInCell:withActionType:)]) {
        [self.CouponCellDelegate clickActionInCell:self withActionType:ShareTicket];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击分享")
}
-(void)leftComposeClick:(ActionBaseView*)sender
{
    if ([self.CouponCellDelegate respondsToSelector:@selector(clickActionInCell:withActionType:)]) {
        [self.CouponCellDelegate clickActionInCell:self withActionType:TicketDetail];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"点击左侧进入优惠券详情")
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat topMargin = 5 ;
    CGFloat leftMargin = 10 ;
    self.container.frame = CGRectMake(leftMargin, topMargin, self.bounds.size.width - 2*leftMargin, self.bounds.size.height-2*topMargin);
    self.container.layer.cornerRadius = 5 ;
    self.container.layer.masksToBounds=YES;
    
    
    
    CGFloat rightH = self.container.bounds.size.height ;
    CGFloat rightW = 112*SCALE;
    
    CGFloat leftH = rightH;
    CGFloat leftW = self.container.bounds.size.width - rightW;
    CGFloat leftX = 0 ;
    CGFloat leftY = 0 ;
    
    CGFloat rightX = leftW;
    CGFloat rightY = 0 ;
    self.leftContainer.frame = CGRectMake(leftX, leftY, leftW, leftH);
    self.rightContainer.frame = CGRectMake(rightX, rightY, rightW, rightH);
    self.midLine.bounds = CGRectMake(0, 0, 1, leftH);
    self.midLine.center = CGPointMake(leftW, leftH/2);
    ////////////////////////////////
    CGFloat leftImageViewH = self.container.bounds.size.height-2*leftMargin ;
    CGFloat leftImageViewW = leftImageViewH ;
    CGFloat leftImageViewX = leftMargin ;
    CGFloat leftImageViewY = leftMargin ;
    self.leftImageView.frame = CGRectMake(leftImageViewX, leftImageViewY, leftImageViewW, leftImageViewH);
    
    self.leftImageView.layer.cornerRadius = 5 ;
    self.leftImageView.layer.masksToBounds=YES;
    
    
    CGFloat midLineW = 1 ;
    CGFloat midLineH = self.container.bounds.size.height ;
    CGFloat centerX = CGRectGetMaxX(self.leftContainer.frame) ;
    CGFloat centerY = self.container.bounds.size.height/2 ;
    self.midLine.bounds  =  CGRectMake(0, 0, midLineW, midLineH);
    self.midLine.center  = CGPointMake(centerX, centerY);
    
    
    
    
    
    
    NSString * showDiscount_price = [ self.couponModel.discount_price convertToYuan];
    
    NSString *contentStr = [NSString stringWithFormat:@"¥ %@",   showDiscount_price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSString * ss = [contentStr substringFromIndex:1];
    NSRange rr = [contentStr rangeOfString:ss];
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
    [str addAttribute:NSKernAttributeName
                value:@(-(5*SCALE))
                range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30*SCALE] range:rr];
    self.price.attributedText=str;
    
    CGFloat priceW = self.leftContainer.bounds.size.width - CGRectGetMaxX(self.leftImageView.frame) - leftMargin ;
    CGFloat priceH = self.leftContainer.bounds.size.height/2 ;
    CGFloat priceX = CGRectGetMaxX(self.leftImageView.frame) + leftMargin ;
    CGFloat priceY = 0 ;
    
    self.price.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    
    NSString * startTime = [self.couponModel.start_time formatterDateString];
    NSString * endTime = [self.couponModel.end_time  formatterDateString];
    self.shopName.text=self.couponModel.title;
    
    CGFloat shopNameW = priceW ;
    CGFloat shopNameH = self.leftContainer.bounds.size.height/4 ;
    CGFloat shopNameX = priceX ;
    CGFloat shopNameY = CGRectGetMaxY(self.price.frame) ;
    self.shopName.frame = CGRectMake(shopNameX,shopNameY,shopNameW,shopNameH);
    
    
    CGFloat timeW = priceW ;
    CGFloat timeH = shopNameH ;
    CGFloat timeX = shopNameX ;
    CGFloat timeY = CGRectGetMaxY(self.shopName.frame);
    self.time.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];
    self.time.frame = CGRectMake(timeX,timeY,timeW,timeH);
    
    
    self.hasGotImageView.center = CGPointMake(CGRectGetMaxX(self.leftContainer.frame) , self.bounds.size.height/2);//去掉 - 100
    
    //    NSInteger limitPrice = 100 ;
    //    self.limit.text = [NSString stringWithFormat:@"满%ld\n即可使用",limitPrice];
    NSString * showFullPrice = [self.couponModel.full_price convertToYuan];
    NSString *fullPriceStr = [NSString stringWithFormat:@"满%@可用", showFullPrice];
    NSMutableAttributedString *discountAttributStr = [[NSMutableAttributedString alloc]initWithString:fullPriceStr];
    NSRange fullPriceRange = [fullPriceStr rangeOfString:self.couponModel.full_price];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromRange(fullPriceRange))
//    NSString * targetStr = [discountStr substringFromIndex:1];
//    NSRange rr = [contentStr rangeOfString:ss];
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
    NSRange manRange = [fullPriceStr rangeOfString:@"满"];
    NSRange keRange = [fullPriceStr rangeOfString:@"可"];
    NSRange lastIntRange = NSMakeRange(keRange.location-1, 1);
    
    [discountAttributStr addAttribute:NSKernAttributeName
                value:@(3*SCALE)
                range:manRange];
    [discountAttributStr addAttribute:NSKernAttributeName
                                value:@(3*SCALE)
                                range:keRange];
    [discountAttributStr addAttribute:NSKernAttributeName//跟右边字符的间距
                                value:@(5*SCALE)
                                range:lastIntRange];
    
    [discountAttributStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12*SCALE] range:fullPriceRange];

    
    self.limit.attributedText = discountAttributStr;
    
    self.limit.frame = CGRectMake(0, 0, self.rightContainer.bounds.size.width, self.rightContainer.bounds.size.height/5*2);
    
    
    
    
    CGFloat marginForRightContainer =10 ;
    
    CGFloat getClickW = (self.rightContainer.bounds.size.width - marginForRightContainer*2 )/2;///45*SCALE ;
    CGFloat getClickH = self.rightContainer.bounds.size.height - CGRectGetMaxY(self.limit.frame) ;
    CGFloat getClickX = marginForRightContainer;
    CGFloat getClickY = CGRectGetMaxY(self.limit.frame) - [@"test" stringSizeWithFont:11].height;
    self.getClick.frame = CGRectMake(getClickX, getClickY, getClickW, getClickH);
//    self.getClick.layer.cornerRadius = self.getClick.bounds.size.height/2;
//    self.getClick.layer.masksToBounds = YES;
    CGFloat shareClickW = getClickW ;
    CGFloat shareClickH = getClickH ;
    CGFloat shareClickX = CGRectGetMaxX(self.getClick.frame);
    CGFloat shareClickY = getClickY;
    self.shareClick.frame = CGRectMake(shareClickX, shareClickY, shareClickW, shareClickH);
}


-(void)setCouponModel:(HCCouponModel *)couponModel{
    _couponModel = couponModel;
    [self.leftImageView sd_setImageWithURL:ImageUrlWithString(couponModel.imgStr) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    if (couponModel.take) {
        self.leftContainer.backgroundColor =[UIColor colorWithHexString:@"dcdcdc"];
        self.rightContainer.backgroundColor = [UIColor colorWithHexString:@"c9c9c9"];
        self.hasGotImageView.hidden = NO;
        self.getClick.bottomTitleColor = [UIColor whiteColor];
        self.getClick.topImage = [UIImage imageNamed:@"bg_icon_draw_nor"];
    }else{

        self.rightContainer.backgroundColor=[UIColor colorWithHexString:@"0e95eb"];
        self.leftContainer.backgroundColor=[UIColor colorWithHexString:@"58c2ff"];
        self.hasGotImageView.hidden = YES;
        self.getClick.bottomTitleColor = [UIColor yellowColor];
        self.getClick.topImage = [UIImage imageNamed:@"bg_icon_draw_sel"];
    }
    [self setNeedsLayout];
}
//-(void)setCellModel:(HCellModel *)cellModel{
//    [super setCellModel:cellModel];
//    self.container.composeModel = cellModel.items.firstObject;
//    
//    self.container.backImageURLStr = self.container.composeModel.imgStr;
//    
//    
//    
//    
//}
@end
