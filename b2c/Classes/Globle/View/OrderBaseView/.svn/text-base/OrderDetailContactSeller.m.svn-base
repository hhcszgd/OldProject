//
//  OrderDetailContactSeller.m
//  b2c
//
//  Created by 0 on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "OrderDetailContactSeller.h"

@implementation OrderDetailContactSeller

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@(screenW));
            make.height.equalTo(@(40));
        }];
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        image.image =[UIImage imageNamed:@"icon_consultation"];
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(image.mas_right).offset(10);
        }];
        [label sizeToFit];
         [label configmentfont:[UIFont systemFontOfSize:12] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"联系卖家"];
    }
    return self;
}
@end
