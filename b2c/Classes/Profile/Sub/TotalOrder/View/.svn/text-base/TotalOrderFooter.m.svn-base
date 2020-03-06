//
//  TotalOrderFooter.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "TotalOrderFooter.h"
@interface TotalOrderFooter()
/**总共数量*/
@property (nonatomic, strong) UILabel *totalCountLabel;
/**合计价格*/
@property (nonatomic, strong) UILabel *totalPriceLabel;
/**运费*/
@property (nonatomic, strong) UILabel *freghtLabel;
/**从右边开始第一个label*/
@property (nonatomic, strong) UILabel *rightFirstLabel;
/**从右边开始第二个label*/
@property (nonatomic, strong) UILabel *rightSecondLabel;
/**从右边开始第三个个label*/
@property (nonatomic, strong) UILabel *rightThirdLabel;
@end
@implementation TotalOrderFooter
- (UILabel *)totalCountLabel{
    if (_totalCountLabel == nil) {
        _totalCountLabel = [[UILabel alloc] init];
        
    }
    return _totalCountLabel;
}

- (UILabel *)totalPriceLabel{
    if (_totalPriceLabel == nil) {
        _totalPriceLabel = [[UILabel alloc] init];
        
    }
    return _totalPriceLabel;
}
- (UILabel *)freghtLabel{
    if (_freghtLabel == nil) {
        _freghtLabel = [[UILabel alloc] init];
   
    }
    return _freghtLabel;
}
- (UILabel *)rightFirstLabel{
    if (_rightFirstLabel == nil) {
        _rightFirstLabel = [[UILabel alloc] init];
        
    }
    return _rightFirstLabel;
}
- (UILabel *)rightSecondLabel{
    if (_rightSecondLabel == nil) {
        _rightSecondLabel = [[UILabel alloc] init];
        
    }
    return _rightSecondLabel;
}
- (UILabel *)rightThirdLabel{
    if (_rightThirdLabel == nil) {
        _rightThirdLabel = [[UILabel alloc] init];
        
    }
    return _rightThirdLabel;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
        
#warning 假数据
        [self.totalCountLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"共%@件商品 合计:",@"1"]];
        [self.totalPriceLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"$233.00"];
        [self.freghtLabel configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:[NSString stringWithFormat:@"(含运费%@)",@"￥12.00"]];
        [self.rightFirstLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"付款"];
        self.rightFirstLabel.layer.borderColor = [[UIColor redColor] CGColor];
        self.rightFirstLabel.layer.borderWidth = 1;
        
        [self.rightSecondLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"取消订单"];
        self.rightSecondLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.rightSecondLabel.layer.borderWidth = 1;
        
        [self.rightThirdLabel configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:3 text:@"朋友代付"];
        self.rightThirdLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.rightThirdLabel.layer.borderWidth = 1;
    }
    return self;
}


@end
