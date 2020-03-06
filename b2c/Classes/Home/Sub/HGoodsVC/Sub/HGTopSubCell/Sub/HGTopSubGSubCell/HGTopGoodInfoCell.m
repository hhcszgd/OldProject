//
//  HGTopGoodInfoCell.m
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGTopGoodInfoCell.h"
#import "HGTopGoodsInfoSub.h"
#import "HGoodsSecurityModel.h"
@interface HGTopGoodInfoCell()
/**商品介绍*/
@property (nonatomic, strong) UILabel *titleLabel;
/**分享按钮*/
@property (nonatomic, strong) ActionBaseView *shareView;
/**价格*/
@property (nonatomic, strong) UILabel *priceStr;
/**催销标题1*/
@property (nonatomic, strong) UILabel *promotion;
/**催销标题2*/
@property (nonatomic, strong) UILabel *Promotion2;
/**促销标题*/
@property (nonatomic, strong) UILabel *promotion3;
@property (nonatomic, strong) UILabel *promotion4;
/**对号图片*/
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIImageView *rightImage2;
@property (nonatomic, strong) UIImageView *rightImage3;
@property (nonatomic, strong) UIImageView *rightImage4;


/**之前的价格*/
@property (nonatomic, strong) UILabel *beforePrice;
//优惠活动
@property (nonatomic, strong) UILabel *discountlabel;
/**快递费*/
@property (nonatomic, strong) UILabel *expressCharge;
/**月销量*/
@property (nonatomic, strong) UILabel *saleVolume;
/**发货地点*/
@property (nonatomic, strong) UILabel *deliveryPlace;



@property (nonatomic, strong) UIView *contentSubView;
@property (nonatomic, strong) MASConstraint *constrainttop;
@property (nonatomic, strong) MASConstraint *constraintHeight;
@property (nonatomic, strong) MASConstraint *constraninWidth;
@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UIImageView *countryImage;

@end
@implementation HGTopGoodInfoCell
- (UIImageView *)titleImage {
    if (_titleImage == nil) {
        _titleImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_titleImage];
        _titleImage.backgroundColor = [UIColor clearColor];
    }
    return _titleImage;
}
- (UIImageView *)countryImage {
    if (_countryImage == nil) {
        _countryImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_countryImage];
        _countryImage.backgroundColor = [UIColor whiteColor];
    }
    return _countryImage;
}
- (UILabel *)titleLabel{
    if (_titleLabel== nil) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel configmentfont:[UIFont systemFontOfSize:15 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (ActionBaseView *)shareView{
    if (_shareView == nil) {
        _shareView = [[ActionBaseView alloc] init];
        [self.contentView addSubview:_shareView];
        [_shareView addTarget:self action:@selector(shar) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_share3"]];
        [_shareView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_shareView.mas_right).offset(-10);
            make.centerY.equalTo(_shareView);
            make.width.equalTo(@(image.image.size.width));
            make.height.equalTo(@(image.image.size.height));
        }];
    }
    return _shareView;
}
- (UILabel *)priceStr{
    if (_priceStr == nil) {
        _priceStr = [[UILabel alloc] init];
        [self.contentView addSubview:_priceStr];
        [_priceStr sizeToFit];
        [_priceStr configmentfont:[UIFont systemFontOfSize:20* zkqScale] textColor:[UIColor colorWithHexString:@"c456b0"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"￥29"];
    
    }
    return _priceStr;
}
- (UILabel *)promotion{
    if (_promotion == nil) {
        _promotion = [[UILabel alloc] init];
        [self.contentView addSubview:_promotion];
        [_promotion configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_promotion sizeToFit];
    }
    return _promotion;
}
- (UILabel *)Promotion2{
    if (_Promotion2 == nil) {
        _Promotion2 = [[UILabel alloc] init];
        [self.contentView addSubview:_Promotion2];
        [_Promotion2 configmentfont:[UIFont systemFontOfSize:11 *zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_Promotion2 sizeToFit];
    }
    return _Promotion2;
}
- (UILabel *)promotion3{
    if (_promotion3 == nil) {
        _promotion3 = [[UILabel alloc] init];
        [self.contentView addSubview:_promotion3];
        [_promotion3 configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_promotion3 sizeToFit];
    }
    return _promotion3;
}
- (UILabel *)promotion4{
    if (_promotion4 == nil) {
        _promotion4 =[[UILabel alloc]init];
        [_promotion4 configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"gjhjkkjgjkjkgjhghjgjhgjhgjh"];
        
        [self.contentView addSubview:_promotion4];
        [_promotion4 sizeToFit];
    }
    return _promotion4;
}
- (UIImageView *)rightImage4{
    if (_rightImage4 == nil) {
        _rightImage4 = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImage4];
    }
    return _rightImage4;
}
- (UIImageView *)rightImage{
    if (_rightImage == nil) {
        _rightImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImage];
        _rightImage.image = [UIImage imageNamed:@"icon_right"];
    }
    return _rightImage;
}
- (UIImageView *)rightImage2{
    if (_rightImage2 == nil) {
        _rightImage2 = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImage2];
        [_rightImage2 setImage:[UIImage imageNamed:@"icon_right"]];
    }
    return _rightImage2;
}
- (UIImageView *)rightImage3{
    if (_rightImage3 == nil) {
        _rightImage3 = [[UIImageView alloc] init];
        [self.contentView addSubview:_rightImage3];
        [_rightImage3 setImage:[UIImage imageNamed:@"icon_right"]];
    }
    return _rightImage3;
}




- (UILabel *)beforePrice{
    if (_beforePrice == nil) {
        _beforePrice = [[UILabel alloc] init];
        [self.contentView addSubview:_beforePrice];
    }
    return _beforePrice;
}
- (UILabel *)discountlabel{
    if (_discountlabel == nil) {
        _discountlabel = [[UILabel alloc] init];
        [self.contentView addSubview:_discountlabel];
    }
    return _discountlabel;
}
- (UILabel *)expressCharge{
    if (_expressCharge == nil) {
        _expressCharge = [[UILabel alloc] init];
        [self.contentView addSubview:_expressCharge];
        [_expressCharge configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_expressCharge sizeToFit];
    }
    return _expressCharge;
}
- (UILabel *)saleVolume{
    if (_saleVolume == nil) {
        _saleVolume = [[UILabel alloc] init];
        [self.contentView addSubview:_saleVolume];
        [_saleVolume configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_saleVolume sizeToFit];
    }
    return _saleVolume;
}
- (UILabel *)deliveryPlace{
    if (_deliveryPlace == nil) {
        _deliveryPlace = [[UILabel alloc] init];
        [self.contentView addSubview:_deliveryPlace];
        [_deliveryPlace configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_deliveryPlace sizeToFit];
    }
    return _deliveryPlace;
}
- (UIView *)contentSubView {
    if (_contentSubView == nil) {
        _contentSubView = [[UIView alloc] init];
        [self.contentView addSubview:_contentSubView];
    }
    return _contentSubView;
}
#pragma mark -- 分享
- (void)shar{
    BaseModel *model = [[BaseModel alloc] init];
    if (self.infoModel.short_name) {
        model.keyParamete = @{@"paramete": self.infoModel.short_name};
    }
    
    NSDictionary *dict = @{@"model": model, @"action": @"goodsShar"};
    [[NSNotificationCenter defaultCenter] postNotificationName:GOODSSNETVALUE object:nil userInfo:dict];
    
}




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self laysub];
    }
    return self;
}

- (void)laysub{
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    //布局分享按钮
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
         make.width.equalTo(@(44));
        make.height.equalTo(@(44));
    }];
    
    
    //布局产品介绍
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.shareView.mas_left).offset(-10);
    }];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.titleLabel.mas_top).offset(0);
        make.width.equalTo(@(69));
        make.height.equalTo(@(17));
    }];
    //布局价格
    [self.priceStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-100);
    }];
    //布局快递
    [self.expressCharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.priceStr.mas_bottom).offset(10);
        
    }];
    //布局月销量
    [self.saleVolume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.expressCharge);
        make.centerX.equalTo(self.contentView);
    }];
    //布局发货地点
    [self.deliveryPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.expressCharge);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [self.countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.deliveryPlace.mas_centerY);
        make.right.equalTo(self.deliveryPlace.mas_left).offset(-5);
        make.width.equalTo(@(25));
        make.height.equalTo(@(25));
    }];
    [self.contentSubView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expressCharge.mas_bottom).offset(0);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(0));
        
    }];
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.height.equalTo(@(10));
        make.width.equalTo(@(screenW));
        make.top.equalTo(self.contentSubView.mas_bottom);
    }];
    lineView.backgroundColor = BackgroundGray;
    
    
}

- (void)setInfoModel:(HGoodsSubGinfoModel *)infoModel{
    _infoModel = infoModel;NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if ([infoModel.sea isEqualToString:@"yes"]) {
        paragraphStyle.firstLineHeadIndent = 79;
        NSMutableAttributedString *infotitle = [[NSMutableAttributedString alloc]initWithString:infoModel.short_name attributes:@{NSParagraphStyleAttributeName: paragraphStyle}];
        self.titleLabel.attributedText = infotitle;
        self.deliveryPlace.text = infoModel.country;
        self.titleImage.image = [UIImage imageNamed:@"icon_earth_zhiyou"];
        self.priceStr.textColor = [UIColor colorWithHexString:@"c456b0"];
    } else {
        self.titleImage.image = [[UIImage alloc] init];
        self.titleLabel.text = infoModel.short_name;
        self.deliveryPlace.text = infoModel.area;
        self.priceStr.textColor = THEMECOLOR;
    }
    
    self.priceStr.attributedText = [infoModel.price dealhomePricefirstFont:[UIFont systemFontOfSize:15] lastfont:[UIFont systemFontOfSize:15]];
    
    
    
    
    
    CGFloat freight = [infoModel.freight floatValue];

    if (infoModel.freight) {
        
        if ([infoModel.freight isEqualToString:@"0"]) {
            self.expressCharge.text = @"包邮";
        }else{
           self.expressCharge.text = [NSString stringWithFormat:@"快递:%0.2f",freight/100];
        }
    }else{
        
        self.expressCharge.text = @"包邮";

    }
        self.saleVolume.text = [NSString stringWithFormat:@"月销量%@件",infoModel.sales_month];

    
    
    NSArray *after = infoModel.security_range;
    CGFloat leftPading = 10.0;
    CGFloat totalW = leftPading;
    CGFloat totalH = 10.0;
    CGFloat margin = 10.0;
    CGFloat leavWidth = screenW;
    for (UIView *view in self.contentSubView.subviews) {
        [view removeFromSuperview];
    }
    if (after && !([after isKindOfClass:[NSNull class]])) {
        for (NSInteger i  = 0; i < after.count; i++) {
           HGoodsSecurityModel *model = infoModel.security_range[i];
            CGSize size = [model.title sizeWithFont:[UIFont systemFontOfSize:11 * zkqScale] MaxSize:CGSizeMake(screenW/2.0, 30)];
            CGSize subSize = CGSizeMake(size.width + 5 + 12 + 5, size.height + 5);
            if (subSize.width > leavWidth) {
                totalH += subSize.height + 5.0;
                totalW = leftPading;
            }
            CGRect frame = CGRectMake(totalW, totalH, subSize.width, subSize.height);
            HGTopGoodsInfoSub *infoSub = [[HGTopGoodsInfoSub alloc] initWithFrame:frame];
            [self.contentSubView addSubview:infoSub];
            [infoSub mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentSubView.mas_left).offset(totalW);
                make.top.equalTo(self.contentSubView.mas_top).offset(totalH);
                make.width.equalTo(@(subSize.width));
                make.height.equalTo(@(subSize.height));
            }];
            infoSub.securityModel = model;
            totalW += margin + subSize.width;
            leavWidth = screenW - totalW;
            
            
        }
        if (after.count == 0) {
            totalH = 5;
        }else {
            totalH += 20 + totalH;
        }
        
    }
    
    [self.contentSubView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(totalH));
    }];
    
    
 
    
    
    
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
