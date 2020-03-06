//
//  HStoreFiveModuleCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreFiveModuleCell.h"

@interface HStoreFiveModuleCell()
/**5个功能模块中的被选择的按钮*/

@end
@implementation HStoreFiveModuleCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (UILabel *)nvaLabel{
    if (_nvaLabel == nil) {
        _nvaLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_nvaLabel];
        [_nvaLabel configmentfont:[UIFont systemFontOfSize:13 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];
        
    }
    return _nvaLabel;
}



- (void)configmentUI{
    self.nvaLabel.frame = self.contentView.bounds;
}

#pragma mark  赋值
- (void)setCollectionView:(UICollectionView *)collectionView{
    
}
- (void)setSubModel:(HStoreSubModel *)subModel{
    self.nvaLabel.text = subModel.title;
    if (subModel.isSelect) {
        self.nvaLabel.textColor = THEMECOLOR;
    }else{
        self.nvaLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
}


@end
