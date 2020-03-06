//
//  HHotMarkSubBigCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HHotMarkSubBigCell.h"
#import "UICollectionViewCell+Extension.h"
@implementation HHotMarkSubBigCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = randomColor;
    }
    return self;
}
-(void)setModel:(id)model{
    
}
@end
