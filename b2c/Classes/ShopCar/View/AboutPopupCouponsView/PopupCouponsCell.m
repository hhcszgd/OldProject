//
//  PopupCouponsCell.m
//  b2c
//
//  Created by wangyuanfei on 6/16/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PopupCouponsCell.h"
#import "HCCouponModel.h"

#import "HCellBaseComposeView.h"
#import "HCCouponcellCompose.h"

@interface PopupCouponsCell ()

@property(nonatomic,weak)HCellBaseComposeView * leftContainer ;
@property(nonatomic,weak)HCellBaseComposeView * rightContainer ;
@property(nonatomic,weak)UIImageView * midLine ;
////////////////////
@property(nonatomic,weak)UILabel * price ;
@property(nonatomic,weak)UILabel * shopName  ;
@property(nonatomic,weak)UILabel * time ;

@property(nonatomic,weak)UILabel * limit ;
@property(nonatomic,weak)UILabel * getLabel ;
@property(nonatomic,weak)UIView * container ;

@property(nonatomic,weak)UIImageView * hasGotImageView ;


@property(nonatomic,weak)UIView * rightSubContainer ;


@end

@implementation PopupCouponsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * container = [[UIView alloc]init];
        //        container.backgroundColor = randomColor;
        self.container = container;
        [self.contentView addSubview:container];
        
        
        
        
        
        HCellBaseComposeView *  rightContainer = [[HCellBaseComposeView alloc]init];
        self.rightContainer =  rightContainer ;
        [self.container addSubview:self.rightContainer];
         [rightContainer addTarget:self action:@selector(finalGotCouponse) forControlEvents:UIControlEventTouchUpInside];
        
        HCellBaseComposeView * leftContainer = [[HCellBaseComposeView alloc]init];
        [leftContainer addTarget:self action:@selector(finalGotCouponse) forControlEvents:UIControlEventTouchUpInside];
        self.leftContainer = leftContainer ;
        [self.container addSubview:self.leftContainer];
        
        UIImageView * midLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon_rec_nor"]];
        self.midLine = midLine;
        [self.container addSubview:self.midLine];
        
        //加
        UIImageView * hasGotImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon_ydraw_nor"]];
        self.hasGotImageView  = hasGotImageView;
        [self.container addSubview:hasGotImageView];

        
        
        UILabel * price =[[UILabel alloc]init];
        price.textColor = [UIColor whiteColor];
        self.price = price;
        price.textAlignment = NSTextAlignmentCenter;
        [self.leftContainer addSubview:self.price];
        //        self.price.backgroundColor=  randomColor;
        
        
        UIView *  rightSubContainer = [[UIView alloc]init];
        self.rightSubContainer = rightSubContainer;
        [self.rightContainer addSubview:rightSubContainer];
        rightSubContainer.userInteractionEnabled = NO;
        
//        rightSubContainer.backgroundColor = randomColor;
        
        
        UILabel * shopName =[[UILabel alloc]init] ;
        shopName.font = [UIFont systemFontOfSize:12*SCALE];
        self.shopName = shopName;
        shopName.textColor = [UIColor whiteColor];
        [self.rightSubContainer addSubview:self.shopName];
        shopName.userInteractionEnabled = NO;
        
        UILabel * time =[[UILabel alloc]init];
        self.time = time;
        time.font = [UIFont systemFontOfSize:9*SCALE];
        time.textColor = [UIColor whiteColor];
        [self.rightSubContainer addSubview:time];
        time.userInteractionEnabled = NO;
        
        UILabel * limit =[[UILabel alloc]init];
        self.limit = limit;
        limit.font = [UIFont systemFontOfSize:11*SCALE];
        limit.textColor = [UIColor whiteColor];
//        limit.numberOfLines = 2;
        [self.rightSubContainer addSubview:limit];
        limit.userInteractionEnabled = NO;
        
        
    }
    return self;
}
/** 领取操作 */
-(void)finalGotCouponse
{
    if ([self.PopupCouponsCellDelegate respondsToSelector:@selector(gotCouponsAction:)]) {
        [self.PopupCouponsCellDelegate gotCouponsAction:self];
    }
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"执行领取优惠券操作");
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat topMargin = 5 ;
    CGFloat leftMargin = 10 ;
    self.container.frame = CGRectMake(leftMargin, topMargin, self.bounds.size.width - 2*leftMargin, self.bounds.size.height-2*topMargin);
    self.container.layer.cornerRadius = 5 ;
    self.container.layer.masksToBounds=YES;
    
    
    
    
    CGFloat leftH = self.container.bounds.size.height;
    CGFloat leftW =  112*SCALE;
    CGFloat leftX = 0 ;
    CGFloat leftY = 0 ;
    
    CGFloat rightH = self.container.bounds.size.height ;
    CGFloat rightW =self.container.bounds.size.width - leftW;
    CGFloat rightX = leftW;
    CGFloat rightY = 0 ;
    self.leftContainer.frame = CGRectMake(leftX, leftY, leftW, leftH);
    self.rightContainer.frame = CGRectMake(rightX, rightY, rightW, rightH);
    self.midLine.bounds = CGRectMake(0, 0, 1, leftH);
    self.midLine.center = CGPointMake(leftW, leftH/2);
    ////////////////////////////////

    
    CGFloat midLineW = 1 ;
    CGFloat midLineH = self.container.bounds.size.height ;
    CGFloat centerX = CGRectGetMaxX(self.leftContainer.frame) ;
    CGFloat centerY = self.container.bounds.size.height/2 ;
    self.midLine.bounds  =  CGRectMake(0, 0, midLineW, midLineH);
    self.midLine.center  = CGPointMake(centerX, centerY);
    
    
    
    
    
    
    NSString * showDiscountPrice = [self.couponModel.discount_price convertToYuan];
    
    NSString *contentStr = [NSString stringWithFormat:@"¥ %@",  showDiscountPrice];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    NSString * ss = [contentStr substringFromIndex:1];
    NSRange rr = [contentStr rangeOfString:ss];
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rr];
    [str addAttribute:NSKernAttributeName
                value:@(-(5*SCALE))
                range:NSMakeRange(0, 1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30*SCALE] range:rr];
    self.price.attributedText=str;
    
    CGFloat priceW = self.leftContainer.bounds.size.width  ;
    CGFloat priceH = self.leftContainer.bounds.size.height ;
    CGFloat priceX = 0 ;
    CGFloat priceY = 0 ;
    
    self.price.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    NSString * startTime = [self.couponModel.start_time formatterDateString];
    NSString * endTime = [self.couponModel.end_time  formatterDateString];
    self.shopName.text=self.couponModel.title;
    
    self.time.text = [NSString stringWithFormat:@"%@-%@",startTime,endTime];

    
    
    self.hasGotImageView.center = CGPointMake(CGRectGetMaxX(self.leftContainer.frame) , self.bounds.size.height/2);//去掉 - 100
    
    NSString * showFullPrice = [self.couponModel.full_price  convertToYuan  ];
    NSString *fullPriceStr = [NSString stringWithFormat:@"满%@可用",showFullPrice];
    NSMutableAttributedString *discountAttributStr = [[NSMutableAttributedString alloc]initWithString:fullPriceStr];
    NSRange fullPriceRange = [fullPriceStr rangeOfString:self.couponModel.full_price];
    
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
    NSString * tongyong = [NSString new] ;
    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.couponModel.type);
    if ([self.couponModel.type isEqualToString:@"1"]) {
        tongyong = @"  (全店通用)";
    }else if([self.couponModel.type isEqualToString:@"2"]){
         tongyong = @"  (指定商品)";
    }
    [discountAttributStr appendAttributedString:[[NSAttributedString alloc] initWithString:tongyong]];
    [discountAttributStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12*SCALE] range:fullPriceRange];
    
    
    self.limit.attributedText = discountAttributStr;
    

    
    
    
    
    CGSize shopNameSize = [self.shopName.text sizeWithFont:self.shopName.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)] ;
//    CGSize limitSize =[self.limit.attributedText.string sizeWithFont:self.limit.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)] ;
    CGSize limitSize =[self.limit.attributedText.string sizeWithFont:[UIFont systemFontOfSize:13*SCALE] MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)] ;
    CGSize timeSize = [self.time.text sizeWithFont:self.time.font MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)] ;
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(shopNameSize));
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(limitSize));
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(timeSize));
    CGFloat maxW = shopNameSize.width > timeSize.width ? shopNameSize.width : timeSize.width;
    
    maxW = maxW > limitSize.width ? maxW : limitSize.width;
//    maxW = maxW > maxW>self.rightContainer.bounds.size.width-10 ? maxW>self.rightContainer.bounds.size.width-10:maxW;
    maxW = maxW > self.rightContainer.bounds.size.width-10 ? self.rightContainer.bounds.size.width-10:maxW;
    CGFloat maxH = shopNameSize.height + limitSize.height + timeSize.height + 10 ;
    
    self.rightSubContainer.bounds = CGRectMake(0, 0, maxW, maxH);
    self.rightSubContainer.center = CGPointMake((self.rightContainer.bounds.size.width+10)/2, self.rightContainer.bounds.size.height/2);

    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(shopNameSize));
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(limitSize));
    LOG(@"_%@_%d_%@",[self class] , __LINE__,NSStringFromCGSize(timeSize));
    CGFloat shopNameW = maxW ;
    CGFloat shopNameH = shopNameSize.height+1 ;
    CGFloat shopNameX = 0 ;
    CGFloat shopNameY = 0 ;
    self.shopName.frame = CGRectMake(shopNameX,shopNameY,shopNameW,shopNameH);
    
    
   
    CGFloat limitX = 0;
    CGFloat limitY = CGRectGetMaxY(self.shopName.frame) ;
    CGFloat limitW = maxW;
    CGFloat limitH = limitSize.height+1;
    self.limit.frame = CGRectMake(limitX, limitY, limitW, limitH);
    
    
    self.limit.hidden=NO;
    
    CGFloat timeW = maxW ;
    CGFloat timeH = timeSize.height+1 ;
    CGFloat timeX = 0 ;
    CGFloat timeY = CGRectGetMaxY(self.limit.frame)+5;

    self.time.frame = CGRectMake(timeX,timeY,timeW,timeH);
    
    
    self.time.hidden = NO ;
}


-(void)setCouponModel:(HCCouponModel *)couponModel{
    _couponModel = couponModel;

    if (couponModel.take) {
        self.leftContainer.backgroundColor =[UIColor colorWithHexString:@"dcdcdc"];
        self.rightContainer.backgroundColor = [UIColor colorWithHexString:@"c9c9c9"];
        self.hasGotImageView.hidden = NO;
    }else{
        
        self.rightContainer.backgroundColor=[UIColor colorWithHexString:@"58c2ff"];
        self.leftContainer.backgroundColor=[UIColor colorWithHexString:@"0e95eb"];
        self.hasGotImageView.hidden = YES;
    }
    [self setNeedsLayout];
}



@end
