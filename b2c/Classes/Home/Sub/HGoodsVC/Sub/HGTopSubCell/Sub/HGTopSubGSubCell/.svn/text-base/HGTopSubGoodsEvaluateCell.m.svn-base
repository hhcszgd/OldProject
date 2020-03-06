//
//  HGTopSubGoodsEvaluateCell.m
//  b2c
//
//  Created by 0 on 16/5/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "HGTopSubGoodsEvaluateCell.h"
#import "HGTopGoodsESubContentView.h"
@interface HGTopSubGoodsEvaluateCell()
@property (nonatomic, strong) HGTopGoodsESubContentView *evluateOne;
@property (nonatomic, strong) HGTopGoodsESubContentView *evluateTwo;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIView *lineView3;
@property (nonatomic, strong) UILabel *evluateTitle;
@property (nonatomic, strong) UILabel *checkAllEvluate;
@property (nonatomic, strong) UIView *lineView4;


@end


@implementation HGTopSubGoodsEvaluateCell
- (UILabel *)evluateTitle{
    if (_evluateTitle == nil) {
        _evluateTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_evluateTitle];
        [_evluateTitle configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor colorWithHexString: @"ffffff"] textAligement:0 cornerRadius:0 text:@""];
        _evluateTitle.frame = CGRectMake(10, 14, 0, 0);
        [_evluateTitle sizeToFit];
    }
    return _evluateTitle;
}

- (UIView *)lineView1{
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView1];
        _lineView1.backgroundColor =BackgroundGray;
        _lineView1.frame = CGRectMake(0, 40, screenW, 1);
    }
    return _lineView1;
}
- (UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView2];
        _lineView2.backgroundColor =BackgroundGray;
    }
    return _lineView2;
}
- (UIView *)lineView3{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView3];
        _lineView3.backgroundColor =BackgroundGray;
    }
    return _lineView3;
}

- (HGTopGoodsESubContentView *)evluateOne{
    if (_evluateOne == nil) {
        _evluateOne = [[HGTopGoodsESubContentView alloc] init];
        [self.contentView addSubview:_evluateOne];
    }
    return _evluateOne;
}
- (HGTopGoodsESubContentView *)evluateTwo{
    if (_evluateTwo == nil) {
        _evluateTwo = [[HGTopGoodsESubContentView alloc] init];
        [self.contentView addSubview:_evluateTwo];
    }
    return _evluateTwo;
}
- (UILabel *)checkAllEvluate{
    if (_checkAllEvluate == nil) {
        _checkAllEvluate = [[UILabel alloc] init];
        [self.contentView addSubview:_checkAllEvluate];
        [_checkAllEvluate configmentfont:[UIFont systemFontOfSize:13 * zkqScale] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:6 * zkqScale text:@"查看全部评价"];
        _checkAllEvluate.layer.borderColor = [[UIColor colorWithHexString:@"999999"] CGColor];
        _checkAllEvluate.layer.borderWidth = 1;
    }
    return _checkAllEvluate;
}

- (UIView *)lineView4{
    if (_lineView4 == nil) {
        _lineView4 = [[UIView alloc] init];
        [self.contentView addSubview:_lineView4];
        _lineView4.backgroundColor = BackgroundGray;
    }
    return _lineView4;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//             make.width.equalTo(@(screenW));
//        }];
        
//        布局
//        [self.evluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(10);
//            make.top.equalTo(self.contentView).offset(14);
//        }];
//        //布局line1
//        [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.contentView);
//            make.top.equalTo(self.evluateTitle.mas_bottom).offset(12);
//            make.height.equalTo(@(1));
//        }];
//        //布局
//        [self.evluateOne mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.lineView1.mas_bottom).offset(0);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(60* SCALE));
//        }];
//        //布局
//        [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(0);
//            make.top.equalTo(self.evluateOne.mas_bottom).offset(0);
//             make.width.equalTo(@(290 * SCALE));
//            make.height.equalTo(@(1));
//        }];
//        //布局
//        [self.evluateTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.lineView2.mas_bottom).offset(0);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(60 * SCALE));
//        }];
//        [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.evluateTwo.mas_bottom).offset(0);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(1));
//        }];
//        
//        //布局
//        [self.checkAllEvluate mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.contentView);
//            make.top.equalTo(self.lineView3.mas_bottom).offset(11);
//            make.height.equalTo(@(33 * SCALE));
//             make.width.equalTo(@(100 * SCALE));
//        }];
//        
//        [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.checkAllEvluate.mas_bottom).offset(11);
//            make.left.right.equalTo(self.contentView);
//            make.height.equalTo(@(10));
//            make.bottom.equalTo(self.contentView).offset(0);
//        }];
    }
    return self;
}


- (void)setCommentModel:(HGTopSubGoodsEvaluateModel *)commentModel{
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
        
    }

    
    self.evluateTitle = nil;
    self.lineView1 = nil;
    self.lineView2 = nil;
    self.lineView3  = nil;
    self.lineView4 = nil;
    self.evluateOne = nil;
    self.evluateTwo = nil;
    self.checkAllEvluate = nil;
    
    
    
    
    switch (commentModel.items.count) {
        case 0:
        {
            [self.evluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(10);
                make.top.equalTo(self.contentView).offset(14);
            }];
            [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(self.evluateTitle.mas_bottom).offset(12);
                make.height.equalTo(@(10));
                make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            }];
           
            self.evluateTitle.text = commentModel.channel ;
            

            
        }
            break;
        case 1:
        {
            [self.evluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(10);
                make.top.equalTo(self.contentView).offset(14);
            }];
            [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.evluateTitle.mas_bottom).offset(12);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(1));
            }];
            [self.evluateOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineView1.mas_bottom).offset(0);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(60* SCALE));
                
            }];
            
            [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.evluateOne.mas_bottom).offset(0);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(10));
                make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            }];
            
            self.evluateOne.subModel = commentModel.items[0];
            self.evluateTitle.text = [commentModel.channel stringByAppendingFormat:@"(%@)",commentModel.num];
            
        }
            break;
        case 2:
        {
//            布局
            [self.evluateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(10);
                make.top.equalTo(self.contentView).offset(14);
            }];
            //布局line1
            [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(self.evluateTitle.mas_bottom).offset(12);
                make.height.equalTo(@(1));
            }];
            //布局
            [self.evluateOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineView1.mas_bottom).offset(0);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(60* SCALE));
            }];
            //布局
            [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(0);
                make.top.equalTo(self.evluateOne.mas_bottom).offset(0);
                make.width.equalTo(@(290 * SCALE));
                make.height.equalTo(@(1));
            }];
            //布局
            [self.evluateTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineView2.mas_bottom).offset(0);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(60 * SCALE));
            }];
            [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.evluateTwo.mas_bottom).offset(0);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(1));
            }];
            
            //布局
            [self.checkAllEvluate mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.contentView);
                make.top.equalTo(self.lineView3.mas_bottom).offset(11);
                make.height.equalTo(@(33 * SCALE));
                make.width.equalTo(@(100 * SCALE));
            }];
            
            [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.checkAllEvluate.mas_bottom).offset(11);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@(10));
                make.bottom.equalTo(self.contentView).offset(0);
            }];
            
            self.evluateOne.subModel = commentModel.items[0];
            self.evluateTitle.text = [commentModel.channel stringByAppendingFormat:@"(%@)",commentModel.num];
            self.evluateTwo.subModel =commentModel.items[1];
            

        }
            break;
        default:
            break;
    }
    
    
    
    
    
}



@end
