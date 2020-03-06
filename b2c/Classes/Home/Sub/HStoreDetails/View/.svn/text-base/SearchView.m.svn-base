//
//  SearchView.m
//  b2c
//
//  Created by 0 on 16/3/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = customColor(234, 234, 234, 234);
        
        
        UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmall_orderlist_search"]];
        searchImage.backgroundColor = [UIColor clearColor];
        [self addSubview:searchImage];
        [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
             make.width.equalTo(@(20));
        }];
        

        UILabel *searchLabel = [[UILabel alloc] init];
        [self addSubview:searchLabel];
        [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.left.equalTo(searchImage.mas_right).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
        [searchLabel configmentfont:[UIFont boldSystemFontOfSize:17] textColor:customColor(133, 133, 133, 1) backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"搜索店铺里面的宝贝"];
    }
    return self;
}



@end
