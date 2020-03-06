//
//  CCCouponsModel.m
//  b2c
//
//  Created by wangyuanfei on 16/5/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CCCouponsCell.h"
#import "CCCouponsModel.h"


@interface CCCouponsCell ()
/** 满多少减多少的label */
@property(nonatomic,weak)UILabel * couponseMoneyLabel ;
/** 所属店铺名字 */
@property(nonatomic,weak)UILabel * shopNameLabel ;
/** 使用期限 */
@property(nonatomic,weak)UILabel * timeLimitLabel ;
/** 图片 */
@property(nonatomic,weak)UIImageView * imgView ;
/** 选择按钮 */
@property(nonatomic,weak)UIButton * chooseButton ;

/** 优惠券按钮(只供显示) */
@property(nonatomic,weak)UIButton * couponseTxtBtn ;

/** 分割线 */
@property(nonatomic,weak)UIView * bottomLine ;
@end

@implementation CCCouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /** 优惠券按钮(只供显示) */
        
        UIButton * couponseTxtBtn =[[UIButton alloc]init];
        self.couponseTxtBtn = couponseTxtBtn;
        [self.contentView addSubview:couponseTxtBtn];
        [self.couponseTxtBtn setBackgroundColor:[UIColor colorWithHexString:@"58c2ff"]];
        [self.couponseTxtBtn setTitle:@"优惠券" forState:UIControlStateNormal];
        [self.couponseTxtBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        
        
        /** 满多少减多少的label */
         UILabel * couponseMoneyLabel = [[UILabel alloc]init];
        self.couponseMoneyLabel = couponseMoneyLabel;
        [self.contentView addSubview:couponseMoneyLabel];
        self.couponseMoneyLabel.font  = [UIFont systemFontOfSize:14];
        self.couponseMoneyLabel.textColor = SubTextColor;
//        self.couponseMoneyLabel.clipsToBounds = YES;
        
        
        /** 所属店铺名字 */
        UILabel * shopNameLabel = [[UILabel alloc]init];
        self.shopNameLabel = shopNameLabel;
        [self.contentView addSubview:shopNameLabel];
        self.shopNameLabel.textColor = SubTextColor;
        self.shopNameLabel.font  = [UIFont systemFontOfSize:14];

        
        /** 使用期限 */
        UILabel * timeLimitLabel =[[UILabel alloc]init];
        self.timeLimitLabel = timeLimitLabel;
        [self.contentView addSubview:timeLimitLabel];
        self.timeLimitLabel.textColor = SubTextColor;
        self.timeLimitLabel.font  = [UIFont systemFontOfSize:12];

        
        /** 图片 */
        UIImageView * imgView= [[UIImageView alloc]init];
        self.imgView = imgView;
        [self.contentView addSubview:imgView];
        imgView.backgroundColor = BackgroundGray;
        
        
        
        
        /** 选择按钮 */
        UIButton * chooseButton =[[UIButton alloc]init];
        self.chooseButton = chooseButton;
        [chooseButton setImage:[UIImage imageNamed:@"btn_round_nor"] forState:UIControlStateNormal];
        [chooseButton setImage:[UIImage imageNamed:@"btn_round_sel"] forState:UIControlStateSelected];
        [self.contentView addSubview:chooseButton];
        [chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        /** 地部分割线 */
        UIView * bottomLine = [[UIView alloc]init];
        self.bottomLine = bottomLine;
        [self.contentView addSubview:self.bottomLine];
        self.bottomLine.backgroundColor = BackgroundGray;
    }
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margint = 10 ;
    
    CGFloat chooseButtonW = 17 ;
    CGFloat chooseButtonH = self.bounds.size.height ;
    CGFloat chooseButtonX = margint*2 ;
    CGFloat chooseButtonY = 0 ;
    self.chooseButton.frame = CGRectMake(chooseButtonX, chooseButtonY, chooseButtonW, chooseButtonH);
    
    CGFloat imgViewW = 68*SCALE ;
    CGFloat imgViewH = imgViewW ;
    CGFloat imgViewX = CGRectGetMaxX(self.chooseButton.frame)+margint ;
    CGFloat imgViewY = (self.bounds.size.height - imgViewW)/2  ;
    self.imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    
    CGFloat couponseTxtBtnX = CGRectGetMaxX(self.imgView.frame)+margint ;
    CGFloat couponseTxtBtnY = CGRectGetMinY(self.imgView.frame) ;
    CGFloat couponseTxtBtnW = 52 ;
    CGFloat couponseTxtBtnH = 24 ;
    self.couponseTxtBtn.frame = CGRectMake(couponseTxtBtnX, couponseTxtBtnY, couponseTxtBtnW, couponseTxtBtnH);
    
    
    CGFloat couponseMoneyW = self.bounds.size.width - margint*2 - CGRectGetMaxX(self.couponseTxtBtn.frame) ;
    CGFloat couponseMoneyH = self.couponseMoneyLabel.font.lineHeight ;
    CGFloat centerX = CGRectGetMaxX(self.couponseTxtBtn.frame)+margint/2 + couponseMoneyW/2 ;
    CGFloat centerY = CGRectGetMidY(self.couponseTxtBtn.frame);
    self.couponseMoneyLabel.bounds = CGRectMake(0, 0, couponseMoneyW, couponseMoneyH);
    self.couponseMoneyLabel.center = CGPointMake(centerX,centerY );
    
    
    CGFloat timeLimeX  = couponseTxtBtnX ;
    CGFloat timeLimeY  = CGRectGetMaxY(self.imgView.frame) - self.timeLimitLabel.font.lineHeight ;
    CGFloat timeLimeW  = self.bounds.size.width - margint - timeLimeX ;
    CGFloat timeLimeH  = self.timeLimitLabel.font.lineHeight ;
    self.timeLimitLabel.frame = CGRectMake(timeLimeX, timeLimeY, timeLimeW, timeLimeH);
    
    
    
    CGFloat shopNameX = timeLimeX ;
    CGFloat shopNameW = timeLimeW ;
    CGFloat shopNameH = timeLimeH ;
    CGFloat shopNameY = CGRectGetMinY(self.timeLimitLabel.frame) - shopNameH ;
    self.shopNameLabel.frame = CGRectMake(shopNameX, shopNameY, shopNameW, shopNameH);
    
    
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 2);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



/** 
 
 contentStr = [headerModel.freight stringValue];
 str = [NSString stringWithFormat:@"运费:共%ld元",[headerModel.freight integerValue]];
 NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:str];
 NSRange  targetRange= [str rangeOfString:contentStr];
 [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:targetRange];
 self.freightLabel.attributedText=attStr;
 
 */

-(void)chooseButtonClick:(UIButton*)sender
{
    if ([self.CouponsCellDelegate respondsToSelector:@selector(chooseCouponseInCell:)]) {
        [self.CouponsCellDelegate chooseCouponseInCell:self];
    }
}

-(void)setCouponsModel:(CCCouponsModel *)couponsModel{
    _couponsModel = couponsModel;
    
    /** 满多少减多少的label */
    
    
    NSString * couponseTxt = @"";
    NSString * limitMoney = [couponsModel.full_price convertToYuan];
    NSString * couponseMoney =[couponsModel.discount_price convertToYuan];
    NSString * totalStr = [NSString stringWithFormat:@"%@满%@减%@元",couponseTxt,limitMoney,couponseMoney];
    NSRange couponseTxtRange =[totalStr rangeOfString:couponseTxt];
    NSRange limitMoneyRange = [totalStr rangeOfString:limitMoney];
    NSRange couponseMoneyRange = [totalStr rangeOfString:couponseMoney options:NSBackwardsSearch];
    
    NSMutableAttributedString * targetAttributeStr = [[NSMutableAttributedString alloc]initWithString:totalStr];
    
    [targetAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:couponseTxtRange];
    [targetAttributeStr addAttribute:NSBackgroundColorAttributeName value:[UIColor blueColor] range:couponseTxtRange];
    
    [targetAttributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0] range:limitMoneyRange];
        [targetAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:limitMoneyRange];
    [targetAttributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0] range:couponseMoneyRange];
        [targetAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:couponseMoneyRange];
    
    self.couponseMoneyLabel.attributedText = targetAttributeStr;
    
    
    
    
    
    
    
    
    
    
    
    
    
    /** 所属店铺名字 */
    self.shopNameLabel.text = couponsModel.shopName;
    
    /** 使用期限 */
    self.timeLimitLabel.text = [NSString stringWithFormat:@"有效期:%@",couponsModel.timeLimit ];
    
    /** 图片 */
    [self.imgView  sd_setImageWithURL:ImageUrlWithString( couponsModel.img) placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
    /** 选择按钮 */
    self.chooseButton.selected = couponsModel.isSelect;
    

}
@end













