//
//  HStroyCollectCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStroyCollectCell.h"
#import "HStroyCellCollectComposeView.h"

@interface HStroyCollectCell()
@property(nonatomic,weak) HStroyCellCollectComposeView* container ;

@end

@implementation HStroyCollectCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        HStroyCellCollectComposeView * container = [[HStroyCellCollectComposeView alloc]init];
        self.container =container;
        [container addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:container];
    }
    return self;
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
    //    _composeModel = composeModel;
    [super setComposeModel:composeModel];
    self.container.composeModel = composeModel;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.container.frame = self.bounds;


}
@end
