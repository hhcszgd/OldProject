//
//  CouponCollectionCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CouponCollectionCell.h"

@interface CouponCollectionCell()



@end
@implementation CouponCollectionCell

- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
        _img.image = [UIImage imageNamed:@"bg_splitline"];
    }
    return _img;
}
- (UILabel *)discount_price{
    if (_discount_price == nil) {
        _discount_price = [[UILabel alloc] init];
        //        [self.contentView addSubview:_discount_price];
        [_discount_price configmentfont:[UIFont systemFontOfSize:13 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_discount_price sizeToFit];
        
    }
    return _discount_price;
}
- (UILabel *)start_to_end{
    if (_start_to_end == nil) {
        _start_to_end = [[UILabel alloc] init];
        //        [self.contentView addSubview:_start_to_end];
        [_start_to_end configmentfont:[UIFont systemFontOfSize:9 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
    }
    return _start_to_end;
}
- (UILabel *)full_price{
    if (_full_price == nil) {
        _full_price = [[UILabel alloc] init];
        //        [self.contentView addSubview:_full_price];
        [_full_price configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_full_price sizeToFit];
        [_full_price setNumberOfLines:2];
    }
    return _full_price;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        //        [self.contentView addSubview:_title];
        [_title configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_title sizeToFit];
    }
    return _title;
}
- (UILabel *)receiveLabel{
    if (_receiveLabel == nil) {
        _receiveLabel = [[UILabel alloc] init];
        //        [self.contentView addSubview:_receiveLabel];
        _receiveLabel.text = @"点击领取";
        CGSize strSize = [_receiveLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12 * SCALE],NSFontAttributeName, nil]];
        CGFloat height = strSize.height + 10 * SCALE;
        [_receiveLabel configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor colorWithHexString:@"ffc323"] textAligement:1 cornerRadius:height/2.0 text:@"点击领取"];
    }
    return _receiveLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //左边的视图
        UIView *leftView = [[UIView alloc] init];
        [self.contentView addSubview:leftView];
        //右边的视图
        UIView *rightView = [[UIView alloc] init];
        [self.contentView addSubview:rightView];
        self.leftView = leftView;
        self.rightView = rightView;
        
        //布局左边
        leftView.frame = CGRectMake(0, 0, 112 * SCALE, frame.size.height);
        rightView.frame = CGRectMake(112 * SCALE , 0, frame.size.width - 112 * SCALE , frame.size.height);
        self.img.frame = CGRectMake(112 *SCALE, 0, 2, frame.size.height);
        //布局discount_price
        [leftView addSubview:self.discount_price];
        [self.discount_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftView.mas_top).offset(5);
            make.centerX.equalTo(leftView.mas_centerX);
            
        }];
        
        //布局title
        [leftView addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.discount_price.mas_bottom).offset(2);
            make.left.equalTo(leftView.mas_left).offset(0);
            make.right.equalTo(leftView.mas_right).offset(0);
        }];
        //布局结束时间
        [leftView addSubview:self.start_to_end];
        [self.start_to_end mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(leftView.mas_bottom).offset(-2);
            make.centerX.equalTo(leftView);
        }];
        
        
        [rightView addSubview:self.full_price];
        [self.full_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightView.mas_top).offset(11);
            make.centerX.equalTo(rightView);
            
        }];
        [rightView addSubview:self.receiveLabel];
        CGSize strSize = [self.receiveLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12 * SCALE],NSFontAttributeName, nil]];
        CGFloat height = strSize.height + 10 * SCALE;
        CGFloat width = strSize.width +12 * SCALE;
        [self.receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(rightView);
            make.top.equalTo(self.full_price.mas_bottom).offset(7);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
        }];
        self.contentView.backgroundColor = [UIColor whiteColor];
//        leftView.backgroundColor = randomColor;
//        rightView.backgroundColor = randomColor;
        [rightView addSubview:self.receiveLabel];
        
        
    }
    return self;
}



- (void)setCustomModel:(CustomCollectionModel *)customModel{
    CGFloat disCountPrice = [customModel.discount_price floatValue];
    NSString *disPrice = [NSString stringWithFormat:@"%0.0f",disCountPrice/100];
    
    NSString *str = [NSString stringWithFormat:@"￥%@",disPrice];
    NSMutableAttributedString *discount_price =[[NSMutableAttributedString alloc] initWithString:str];
    [discount_price addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13 * SCALE],NSFontAttributeName, nil] range:NSMakeRange(0, 1)];
    [discount_price addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:30 * SCALE],NSFontAttributeName, nil] range:NSMakeRange(1, str.length - 1)];
    self.discount_price.attributedText = discount_price;
    
    self.title.text = customModel.title;
    NSRange startRange = [customModel.start_time rangeOfString:@" "];
    NSRange endRange = [customModel.end_time rangeOfString:@" "];
    
    
    NSString * startTime = [[customModel.start_time substringToIndex:startRange.location] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    
    NSString * endTime = [[customModel.start_time substringToIndex:endRange.location] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    
    
    self.start_to_end.text = [startTime stringByAppendingFormat:@"-%@",endTime];
    CGFloat discountPrie = [customModel.discount_price floatValue];
    CGFloat fullPrice = [customModel.full_price floatValue];
    if (discountPrie/100 < 50) {
        self.leftView.backgroundColor = [UIColor colorWithHexString:@"56e4ad"];
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"09c979"];
    }
    if ((discountPrie/100 >= 50)&& (discountPrie/100 <100)) {
        self.leftView.backgroundColor = [UIColor colorWithHexString:@"58c2ff"];
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"318bf0"];
    }
    if ((discountPrie/100 >= 100)&& (discountPrie/100 <500)) {
        self.leftView.backgroundColor = [UIColor colorWithHexString:@"ff6767"];
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"ed3b3b"];
    }
    if (discountPrie/100 >= 500) {
        self.leftView.backgroundColor = [UIColor colorWithHexString:@"c664ff"];
        self.rightView.backgroundColor = [UIColor colorWithHexString:@"9d31f0"];
    }
    NSString *fPrice = [NSString stringWithFormat:@"%0.0f",fullPrice/100];
    self.full_price.text = [NSString stringWithFormat:@"满%@\n即可使用",fPrice];
    
}
@end
