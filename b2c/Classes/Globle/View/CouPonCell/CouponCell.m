//
//  CouponCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell()
/**优惠券的价格*/
@property (nonatomic, strong) UILabel  *pricelabel;
/**优惠券的有效时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**优惠券的使用限制*/
@property (nonatomic, strong) UILabel *limitLabel;
@end
@implementation CouponCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:252/255.0f green:94/255.0f blue:98/255.0f alpha:1];
        __weak typeof(self) Myself = self;
        UILabel *priceLabel = [UILabel new];
        [self.contentView addSubview:priceLabel];
        _pricelabel = priceLabel;
        priceLabel.textColor = [UIColor whiteColor];
        [priceLabel sizeToFit];
        //        priceLabel.text = @"$3";
        priceLabel.font = [UIFont boldSystemFontOfSize:24];
        [priceLabel sizeToFit];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Myself.contentView.mas_top).offset(5);
            make.left.equalTo(Myself.contentView.mas_left).offset(5);
        }];
        
        _pricelabel = priceLabel;
        
        
        
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:220/255.0f green:81/255.0f blue:86/255.0f alpha:1];
        label.font = [UIFont systemFontOfSize:13];
        label.text =  @"领";
        CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(Myself.contentView);
            make.width.equalTo(@(size.width + 10));
        }];
        //设置行距
        label.text = @"领取";
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributeString.length)];
        
        label.attributedText = attributeString;
        
        
        
        UILabel *timeLabel = [UILabel new];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(Myself.contentView);
            make.right.equalTo(label.mas_left).offset(0);
            make.height.equalTo(@(20));
        }];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.adjustsFontSizeToFitWidth = YES;
        //        timeLabel.text  =@"2016.01.22-2016.03.30";
        
        _timeLabel = timeLabel;
        
        
        
        UILabel *limitLabel = [UILabel new];
        [self.contentView addSubview:limitLabel];
        [limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(timeLabel.mas_top).offset(2);
            make.right.equalTo(label.mas_left).offset(-3);
        }];
        limitLabel.textColor = [UIColor whiteColor];
        limitLabel.textAlignment  = NSTextAlignmentCenter;
        [limitLabel sizeToFit];
        limitLabel.font = [UIFont systemFontOfSize:12];
        //        limitLabel.text = @"满198元使用";
        _limitLabel = limitLabel;
        
        
    }
    return self;
}


- (void)setDic:(NSDictionary *)dic{
    NSString *price = dic[@"price"];
    NSString *time = dic[@"time"];
    NSString *limit = dic[@"limit"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:24], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(1, price.length - 1)];
    _pricelabel.attributedText = attributedString;
    _timeLabel.text = time;
    _limitLabel.text = limit;
    
}




@end
