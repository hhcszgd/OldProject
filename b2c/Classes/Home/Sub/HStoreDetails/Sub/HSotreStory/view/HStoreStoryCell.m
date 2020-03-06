//
//  HStoreStoryCell.m
//  b2c
//
//  Created by 0 on 16/4/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreStoryCell.h"
#import "HStoreStoryModel.h"
@interface HStoreStoryCell()
/**故事标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/**故事浏览量*/
@property (nonatomic, strong) UILabel *scanLabel;
/**发布时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**浏览图片*/
@property (nonatomic, strong) UIImageView *scanImage;
@end
@implementation HStoreStoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}
- (UILabel *)scanLabel{
    if (_scanLabel == nil) {
        _scanLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_scanLabel];
    }
    return _scanLabel;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel  =[[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)scanImage{
    if (_scanImage == nil) {
        _scanImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_scanImage];
    }
    return _scanImage;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
             make.width.equalTo(@(100));
        }];
        [self.scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.timeLabel.mas_left).offset(-10);
             make.width.equalTo(@(20));
        }];
        [self.scanImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.scanLabel.mas_left).offset(0);
             make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        self.scanImage.image = [UIImage imageNamed:@"shop_iconfont-message"];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.scanImage.mas_left).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
    }
    return self;
}
- (void)setModel:(id)model{
    HStoreStoryModel *storeModel = model;
    [self.timeLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:storeModel.time];
    [self.titleLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:storeModel.title];
    [self.scanLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:storeModel.count];
}


@end
