
//
//  ConfirmOrderAddressView.m
//  b2c
//
//  Created by wangyuanfei on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ConfirmOrderAddressView.h"
#import "ConfirmOrderNormalCellModel.h"
#import "AMCellModel.h"

@interface ConfirmOrderAddressView()
@property(nonatomic,weak)UILabel * nameLabel ;
//@property(nonatomic,weak)UILabel * telLabel ;
@property(nonatomic,weak)UIImageView * locationImage ;
@property(nonatomic,weak)UILabel * addressLabel ;
@property(nonatomic,weak)UIImageView * arrow ;
@property(nonatomic,weak)UIImageView * bottomLine ;

@end


@implementation ConfirmOrderAddressView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * arrow  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"] ];
        [self addSubview:arrow];
        self.arrow = arrow;

        UILabel * nameLabel =  [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:15*SCALE];
        nameLabel.textColor = MainTextColor;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
//        nameLabel.backgroundColor = randomColor;
        
        
//        UILabel * telLabel =  [[UILabel alloc]init];
//        self.telLabel = telLabel;
//        [self addSubview:telLabel];
//        telLabel.backgroundColor = randomColor;
        
        UIImageView * locationImage  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon_tu"] ];
        [self addSubview:locationImage];
        self.locationImage = locationImage;

//        [[UIButton new] contentHorizontalAlignment]
        UILabel * addressLabel =  [[UILabel alloc]init];
        self.addressLabel = addressLabel;
        addressLabel.numberOfLines = 5 ;
        addressLabel.font = [UIFont systemFontOfSize:14*SCALE];
        addressLabel.textColor = MainTextColor;
//        addressLabel.contentHorizontalAlignment
        [self addSubview:addressLabel];
//        addressLabel.backgroundColor = randomColor;

        
        UIImageView * bottomLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon"]];
//        bottomLine.backgroundColor = randomColor;
        self.bottomLine = bottomLine ;
        
        [self addSubview:bottomLine];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
//    CGFloat maxW =  screenW - 10 - 8 -10 -10 - 13- 5 ;
//    CGFloat topH = [@"测试"   stringSizeWithFont:15*SCALE].height ;
//    CGFloat bottomH = 3 ;
//    
//     CGSize  addressLabelSize =  [@"地址" sizeWithFont:[UIFont systemFontOfSize:14 *SCALE] MaxSize:CGSizeMake(maxW, CGFLOAT_MAX)];
    
    
    CGFloat margin = 10 ;
    CGFloat arrowW = 8 ;
    CGFloat arrowH = 14 ;
    CGFloat arrowX = self.bounds.size.width - margin - arrowW  ;
    CGFloat arrowY = (self.bounds.size.height- arrowH )/2  ;
    self.arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    
    CGSize  nameSize = [self.nameLabel.text stringSizeWithFont:15*SCALE];
    
    CGFloat nameLabelW = nameSize.width ;
    CGFloat nameLabelH = nameSize.height ;
    CGFloat nameLabelX = CGRectGetMaxX(self.locationImage.frame)+margin/2  ;
    CGFloat nameLabelY = margin/2  ;
    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    
    
    CGFloat locationImageW = 13 ;
    CGFloat locationImageH = 17 ;
    CGFloat locationImageX = margin  ;
    CGFloat locationImageY = CGRectGetMaxY(self.nameLabel.frame) + margin/2  ;
    self.locationImage.frame = CGRectMake(locationImageX, locationImageY,locationImageW, locationImageH);

//    CGSize  nameSize = [self.nameLabel.text stringSizeWithFont:15*SCALE];
//    
//    CGFloat nameLabelW = nameSize.width ;
//    CGFloat nameLabelH = nameSize.height ;
//    CGFloat nameLabelX = CGRectGetMaxX(self.locationImage.frame)+margin/2  ;
//    CGFloat nameLabelY = (self.bounds.size.height/10*4 - nameLabelH)/2  ;
//    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
//    
    
    CGSize  addressLabelSize =  [self.addressLabel.text sizeWithFont:self.addressLabel.font MaxSize:CGSizeMake(CGRectGetMinX(self.arrow.frame) - CGRectGetMaxX(self.locationImage.frame) - margin-margin, CGFLOAT_MAX)];  // [self.addressLabel.text stringSizeWithFont:16];
    
    CGFloat addressLabelMaxH = [self.addressLabel.text stringSizeWithFont:15*SCALE].height*5;
    CGFloat addressLabelH = addressLabelSize.height ;
//    CGFloat maxWidth = CGRectGetMinX(self.arrow.frame) - CGRectGetMaxX(self.locationImage.frame) - margin-margin;
//    if (addressLabelSize.width>maxWidth) {
//        addressLabelH = addressLabelSize.height*2 ;
//    }
//    if (addressLabelH>addressLabelMaxH)   addressLabelH=addressLabelMaxH;
    addressLabelH = addressLabelH>addressLabelMaxH ?addressLabelMaxH : addressLabelH;
    CGFloat addressLabelW = CGRectGetMinX(self.arrow.frame) - CGRectGetMaxX(self.locationImage.frame) - margin-margin ;

    CGFloat addressLabelX = CGRectGetMaxX(self.locationImage.frame)+margin/2  ;
    CGFloat addressLabelY = locationImageY  ;
    self.addressLabel.frame = CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
    self.addressLabel.textColor = SubTextColor;
    
    CGFloat bottomLineW = self.bounds.size.width ;
    CGFloat bottomLineH = 3 ;
    CGFloat bottomLineX = 0  ;
    CGFloat bottomLineY = self.bounds.size.height-bottomLineH  ;
    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);

    
    
    
    
    //////////
//    CGFloat margin = 10 ;
//    CGFloat arrowW = 8 ;
//    CGFloat arrowH = 14 ;
//    CGFloat arrowX = self.bounds.size.width - margin - arrowW  ;
//    CGFloat arrowY = (self.bounds.size.height- arrowH )/2  ;
//    self.arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
//    
//    CGFloat locationImageW = 13 ;
//    CGFloat locationImageH = 17 ;
//    CGFloat locationImageX = margin  ;
//    CGFloat locationImageY = self.bounds.size.height/10*4  ;
//    self.locationImage.frame = CGRectMake(locationImageX, locationImageY,locationImageW, locationImageH);
//    
//    CGSize  nameSize = [self.nameLabel.text stringSizeWithFont:15*SCALE];
//    
//    CGFloat nameLabelW = nameSize.width ;
//    CGFloat nameLabelH = nameSize.height ;
//    CGFloat nameLabelX = CGRectGetMaxX(self.locationImage.frame)+margin/2  ;
//    CGFloat nameLabelY = (self.bounds.size.height/10*4 - nameLabelH)/2  ;
//    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
//    
//    
//    CGSize  addressLabelSize =  [self.addressLabel.text sizeWithFont:self.addressLabel.font MaxSize:CGSizeMake(CGRectGetMinX(self.arrow.frame) - CGRectGetMaxX(self.locationImage.frame) - margin-margin, CGFLOAT_MAX)];  // [self.addressLabel.text stringSizeWithFont:16];
//    CGFloat addressLabelMaxH = [self.addressLabel.text stringSizeWithFont:15*SCALE].height*3;
//    CGFloat addressLabelH = addressLabelSize.height ;
//    //    CGFloat maxWidth = CGRectGetMinX(self.arrow.frame) - CGRectGetMaxX(self.locationImage.frame) - margin-margin;
//    //    if (addressLabelSize.width>maxWidth) {
//    //        addressLabelH = addressLabelSize.height*2 ;
//    //    }
//    //    if (addressLabelH>addressLabelMaxH)   addressLabelH=addressLabelMaxH;
//    addressLabelH = addressLabelH>addressLabelMaxH ?addressLabelMaxH : addressLabelH;
//    CGFloat addressLabelW = CGRectGetMinX(self.arrow.frame) - CGRectGetMaxX(self.locationImage.frame) - margin-margin ;
//    
//    CGFloat addressLabelX = CGRectGetMaxX(self.locationImage.frame)+margin/2  ;
//    CGFloat addressLabelY = locationImageY  ;
//    self.addressLabel.frame = CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
//    self.addressLabel.textColor = SubTextColor;
//    
//    CGFloat bottomLineW = self.bounds.size.width ;
//    CGFloat bottomLineH = 3 ;
//    CGFloat bottomLineX = 0  ;
//    CGFloat bottomLineY = self.bounds.size.height-bottomLineH  ;
//    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);

}



-(void)setCellModel:(ConfirmOrderNormalCellModel *)cellModel{
    _cellModel = cellModel;
    
    if ([cellModel.items isKindOfClass:[NSArray class] ] && cellModel.items.count>0) {

        AMCellModel * addressModel = cellModel.items.firstObject;
        
        NSString * name = addressModel.username;
        NSString * mobile = addressModel.mobile;
        NSString * address = [NSString stringWithFormat:@"%@%@",addressModel.area,addressModel.address];
        if (name.length>10) {
            name = [name substringWithRange:NSMakeRange(0, 10)];
            name = [name stringByAppendingString:@"..."];
        }
        
        self.nameLabel.text = [NSString stringWithFormat:@"%@    %@",name,mobile];
        self.addressLabel.text = [NSString stringWithFormat:@"%@",address];
        LOG(@"_%@_%d_%@",[self class] , __LINE__,addressModel.username);

    }
    
    
    [self setNeedsLayout];
    
}
@end
