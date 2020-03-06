//
//  ABrandCell.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "ABrandCell.h"
@interface ABrandCell()
/**品牌图片*/
@property (nonatomic, strong) UIImageView *aBrandImage;
/**品牌名*/
@property (nonatomic, strong) UILabel *aBrandName;
@end
@implementation ABrandCell

- (UIImageView *)aBrandImage{
    if (_aBrandImage == nil) {
        _aBrandImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_aBrandImage];
    }
    return _aBrandImage;
}

- (UILabel *)aBrandName{
    if (_aBrandName == nil) {
        _aBrandName = [[UILabel alloc] init];
        [self.contentView addSubview:_aBrandName];
    }
    return _aBrandName;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(screenW));
        }];
        //布局图片和文字
        [self.aBrandImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.equalTo(self.aBrandImage.mas_height);
            make.height.equalTo(@(80));
        }];
        [self.aBrandName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.aBrandImage.mas_right).offset(10);
        }];
        [self.aBrandName sizeToFit];
        
        UIImageView *indicate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sen"]];
        [self.contentView addSubview:indicate];
//        indicate.backgroundColor = randomColor;
        [indicate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
             make.width.equalTo(@(15));
            make.height.equalTo(@(15));
        }];
        
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(@(1));
        }];
        line.backgroundColor = BackgroundGray;
        
        
    }
    return self;
}

- (void)setBrandModel:(ABrandModel *)brandModel{
    self.aBrandImage.image = [UIImage imageNamed:@"me"];
    [self.aBrandName configmentfont:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"振文斯"];
}



@end
