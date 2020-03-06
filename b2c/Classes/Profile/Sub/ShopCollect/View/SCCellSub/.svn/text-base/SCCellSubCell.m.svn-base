//
//  SCCellSubCell.m
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SCCellSubCell.h"

@implementation SCCellSubCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //固定图片的高度
        
        
        [self.BCImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.BCImageView.mas_width);
        }];
        //创建三个label
        //商品信息
        [self.BCTitleLabel sizeToFit];
        

        //布局控件
        [self.BCTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.BCImageView.mas_bottom).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];


    }
    return self;
}


- (void)setScSubModel:(SCCellSubModel *)scSubModel{
    _scSubModel = scSubModel;
    self.BCImageView.image = [UIImage imageNamed:@"zhekouqu"];
    [self.BCTitleLabel configmentfont:[UIFont systemFontOfSize:13] textColor:[UIColor redColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"$12.5"];
}
@end
