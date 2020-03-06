//
//  HAPHotCategotyCell.m
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAPHotCategotyCell.h"

@interface HAPHotCategotyCell()
@property (nonatomic, strong) UIImageView *categaryImage;
@property (nonatomic, strong) UILabel *classifyTitle;
@property (nonatomic, strong) MASConstraint *constraint1;
@property (nonatomic, strong) MASConstraint *constraint2;


@end
@implementation HAPHotCategotyCell
- (UIImageView *)categaryImage{
    if (_categaryImage == nil) {
        _categaryImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_categaryImage];
    }
    return _categaryImage;
}

- (UILabel *)classifyTitle{
    if (_classifyTitle == nil) {
        _classifyTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_classifyTitle];
        [_classifyTitle configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@""];
        [_classifyTitle sizeToFit];
    }
    return _classifyTitle;
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    [self.categaryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.classifyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       self.constraint1 = make.top.equalTo(self.contentView).offset(10);
       self.constraint2 =  make.left.equalTo(self.contentView).offset(-10);
    }];
    
}





- (void)setCustomModel:(CustomCollectionModel *)customModel{
    
    NSURL *url = ImageUrlWithString(customModel.img);
    [self.categaryImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];
//    self.classifyTitle.text = customModel.hotName;
    
}

- (void)setCellStyle:(HEaCellStyle)cellStyle{
    
    switch (cellStyle) {
        case cellStyleIsBig:
        {
            [self.constraint1 uninstall];
            [self.constraint2 uninstall];
            [self.classifyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                self.constraint1 =  make.left.equalTo(self.contentView.mas_left).offset(10);
                self.constraint2 =  make.top.equalTo(self.contentView.mas_top).offset(10);
            }];
        }
            break;
        case cellStyleIsSmall:
        {
            
            [self.constraint1 uninstall];
            [self.constraint2 uninstall];
            [self.classifyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                self.constraint1 = make.centerX.equalTo(self.contentView);
                self.constraint2 =  make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            }];
            
        }
            break;
        default:
            break;
    }
    
}


@end
