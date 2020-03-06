//
//  HGTopSpecificationCell.m
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGTopSpecificationCell.h"
@interface HGTopSpecificationCell()
/**选规格*/
@property (nonatomic, strong) UILabel *channel;
/**选择数量*/
@property (nonatomic, strong) UILabel *num;
/**选择颜色尺寸*/
@property (nonatomic, strong) UILabel *spec;
/**lineView*/
@property (nonatomic, strong) UIView *lineView;
@end
@implementation HGTopSpecificationCell
- (UILabel *)channel{
    if (_channel == nil) {
        _channel = [[UILabel alloc] init];
        [self.contentView addSubview:_channel];
        [_channel configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString:@"ffffff"] textAligement:0 cornerRadius:0 text:@"请选择"];
        [_channel sizeToFit];
    }
    return _channel;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [[UILabel alloc] init];
        [self.contentView addSubview:_num];
        [_num configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_num sizeToFit];
    }
    return _num;
}
- (UILabel *)spec{
    if (_spec == nil) {
        _spec = [[UILabel alloc] init];
        [self.contentView addSubview:_spec];
        [_spec configmentfont:[UIFont systemFontOfSize:11 * zkqScale] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_spec sizeToFit];
    }
    return _spec;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}




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
        [self laysub];
    }
    return self;
}
- (void)laysub{
    
    [self.channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        
    }];
    //布局规格
    [self.spec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.channel.mas_right).offset(20*SCALE);
        make.centerY.equalTo(self.channel);
        
    }];
    //布局数量
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.channel);
        make.left.equalTo(self.spec.mas_right).offset(20* SCALE);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channel.mas_bottom).offset(14);
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@(10));
        make.width.equalTo(@(screenW));
    }];
    self.lineView.backgroundColor =BackgroundGray;
    
    
}
- (void)setSpecificationModel:(HGTopSepecificationModel *)specificationModel{
    self.channel.text = specificationModel.info;
    self.spec.text = specificationModel.myspec;
    self.num.text = specificationModel.num;
}



@end
