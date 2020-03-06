//
//  CateGaryItem.m
//  TTmall
//
//  Created by 0 on 16/1/28.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "HSpecItem.h"

@interface HSpecItem()
@property (nonatomic, strong) UICollectionView *father;
@end

@implementation HSpecItem
- (UIButton *)button{
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        [self.contentView addSubview:_button];
        _button.selected = NO;
        [_button setBackgroundImage:[UIImage ImageWithColor:[UIColor colorWithHexString:@"f4f4f4"] frame:self.frame] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage ImageWithColor:THEMECOLOR frame:self.frame] forState:UIControlStateSelected];
        [_button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithHexString:@"fefefe"] forState:UIControlStateSelected];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:12 *zkqScale]];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
        }];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 2;
        
    }
    return self;
}
- (void)buttonClick:(UIButton *)button{
    //让其代理执行代理方法
    if ([self.delegate respondsToSelector:@selector(cateCarycell:atIndexPath:button:)]) {
        UICollectionView *collectionView =(UICollectionView *) self.father;
        NSIndexPath *indxPath = [collectionView indexPathForCell:self];
        [self.delegate cateCarycell:self atIndexPath:indxPath button:button];
    }

}

-(void)setDeatilModel:(HSepcSubTypeDetailModel *)deatilModel{
    [self.button setTitle:deatilModel.quality forState:UIControlStateNormal];
    self.button.selected = deatilModel.isSelect;
    NSInteger count = [deatilModel.reserced integerValue];
    if (count == 0) {
        self.button.userInteractionEnabled = NO;
        self.button.alpha = 0.5;
    }else{
        self.button.userInteractionEnabled = YES;
        self.button.alpha = 1;
    }
    
}




- (void)setFatherView:(UICollectionView *)fatherView{
    self.father = fatherView;
}

@end
