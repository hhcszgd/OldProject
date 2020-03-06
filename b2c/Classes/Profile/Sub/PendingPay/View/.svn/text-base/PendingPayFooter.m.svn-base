//
//  PendingPayFooter.m
//  b2c
//
//  Created by 0 on 16/4/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PendingPayFooter.h"

@implementation PendingPayFooter

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *shangView = [[UIView alloc] init];
        [self addSubview:shangView];
        UIView *xiaView = [[UIView alloc] init];
        [self addSubview:xiaView];
        [shangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(82));
        }];
        [xiaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shangView.mas_bottom).offset(0);
            make.left.bottom.right.equalTo(self);
            
        }];
        xiaView.backgroundColor = BackgroundGray;
        //上部的view
        UIView *topView = [[UIView alloc] init];
        [shangView addSubview:topView];
        
        topView.backgroundColor = [UIColor whiteColor];
        
        //间隔线
        UIView *lineView = [[UIView alloc] init];
        [shangView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(shangView);
            make.left.right.equalTo(shangView);
            make.height.equalTo(@(2));
        }];
        lineView.backgroundColor = BackgroundGray;
        //下部的view
        UIView *bottomView =[[UIView alloc] init];
        [shangView addSubview:bottomView];
        bottomView.backgroundColor = [UIColor whiteColor];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(0);
            make.left.right.bottom.equalTo(shangView);
        }];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(shangView);
            make.bottom.equalTo(lineView.mas_top).offset(0);
        }];
        
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        //布局运费
        [topView addSubview:self.freghtLabel];
        [self.freghtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(topView.mas_right).offset(-10);
        }];
        [self.freghtLabel sizeToFit];
        //布局价格
        [topView addSubview:self.totalPriceLabel];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(self.freghtLabel.mas_left).offset(-5);
        }];
        [self.totalPriceLabel sizeToFit];
        //布局总数量
        [topView addSubview:self.totalCountLabel];
        [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(self.totalPriceLabel.mas_left).offset(-5);
        }];
        [self.totalCountLabel sizeToFit];
        
        //布局第一个label
        [bottomView addSubview:self.rightFirstLabel];
        [self.rightFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bottomView.mas_right).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(27));
            make.width.equalTo(@(75 *SCALE));
        }];
        
        //布局第二个label
        [bottomView addSubview:self.rightSecondLabel];
        [self.rightSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightFirstLabel.mas_left).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(27));
            make.width.equalTo(@(75 *SCALE));
            
        }];
        
        //布局第三个label
        [bottomView addSubview:self.rightThirdLabel];
        [self.rightThirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightSecondLabel.mas_left).offset(-10);
            make.centerY.equalTo(bottomView);
            make.height.equalTo(@(27));
            make.width.equalTo(@(75 *SCALE));
        }];

        self.rightThirdLabel.layer.borderWidth = 1;
        
        
        
#pragma mark 假数据
        [self.totalCountLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"共%@件商品 合计:",@"1"]];
        [self.totalPriceLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"$233.00"];
        [self.freghtLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"(含运费%@)",@"￥12.00"]];
    }
    return self;
}




- (void)cancleOrderTap:(UITapGestureRecognizer *)cancleOrderTap{
    [super cancleOrderTap:cancleOrderTap];
    //取消订单之后订单变为交易关闭状态。该页面就不会显示；
    if ([self.delegate respondsToSelector:@selector(deleteOrder:section:)]) {
        LOG(@"%@,%d,%ld",[self class], __LINE__,self.section)
        [self.delegate performSelector:@selector(deleteOrder:section:) withObject:self.orderModel withObject:@(self.section)];
    }
}


@end
