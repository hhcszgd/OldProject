//
//  HGTopEvaluateCell.m
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGTopEvaluateCell.h"
@interface HGTopEvaluateCell()
/**channel*/
@property (nonatomic, strong) UILabel *channel;
/**头像*/
@property (nonatomic, strong) UIImageView *headPortrait1;
/**用户名*/
@property (nonatomic, strong) UILabel *nikeName1;
/**内容*/
@property (nonatomic, strong) UILabel *content1;

/**头像*/
@property (nonatomic, strong) UIImageView *headPortrait2;
/**用户名*/
@property (nonatomic, strong) UILabel *nikeName2;
/**内容*/
@property (nonatomic, strong) UILabel *content2;

/**查看全部评价*/
@property (nonatomic, strong) UILabel *allRecomment;

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIView *lineView3;



@end
@implementation HGTopEvaluateCell
- (UILabel *)channel{
    if (_channel == nil) {
        _channel = [[UILabel alloc] init];
        [self.contentView addSubview:_channel];
    }
    return _channel;
}
- (UIImageView *)headPortrait1{
    if (_headPortrait1 == nil) {
        _headPortrait1 = [[UIImageView alloc] init];
        [self.contentView addSubview:_headPortrait1];
    }
    return _headPortrait1;
}
- (UILabel *)nikeName1{
    if (_nikeName1 == nil) {
        _nikeName1 = [[UILabel alloc] init];
        [self.contentView addSubview:_nikeName1];
    }
    return _nikeName1;
}
- (UILabel *)content1{
    if (_content1 == nil) {
        _content1 = [[UILabel alloc] init];
        [self.contentView addSubview:_content1];
    }
    return _content1;
}
- (UILabel *)nikeName2{
    if (_nikeName2 == nil) {
        _nikeName2 = [[UILabel alloc] init];
        [self.contentView addSubview:_nikeName2];
    }
    return _nikeName2;
}
- (UIImageView *)headPortrait2{
    if (_headPortrait2 == nil) {
        _headPortrait2 = [[UIImageView alloc] init];
        [self.contentView addSubview:_headPortrait2];
    }
    return _headPortrait2;
}
- (UILabel *)content2{
    if (_content2 == nil) {
        _content2 = [[UILabel alloc] init];
        [self.contentView addSubview:_content2];
    }
    return _content2;
}
- (UILabel *)allRecomment{
    if (_allRecomment == nil) {
        _allRecomment = [[UILabel alloc] init];
        [self.contentView addSubview:_allRecomment];
        [_allRecomment configmentfont:[UIFont systemFontOfSize:15 ] textColor:[UIColor colorWithHexString:@"eeeeee"] backColor:[UIColor clearColor] textAligement:1 cornerRadius:6 text:@"查看全部评价"];
        _allRecomment.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _allRecomment.layer.borderWidth = 1;
    }
    return _allRecomment;
}
- (UIView *)lineView1{
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView1];
        _lineView1.backgroundColor = BackgroundGray;
    }
    return _lineView1;
}

- (UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView2];
        _lineView2.backgroundColor = BackgroundGray;
    }
    return _lineView2;
}
- (UIView *)lineView3{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView3];
        _lineView3.backgroundColor = BackgroundGray;
    }
    return _lineView3;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self laysub];
    }
    return self;
}
- (void)laysub{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.equalTo(@(screenW));
    }];
    //布局Channel
    [self.channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.height.equalTo(@(40));
        make.right.equalTo(self.contentView.mas_right).offset(0);
    }];
    //布局细线
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channel.mas_bottom).offset(0);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(1));
    }];
    //布局
    
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
