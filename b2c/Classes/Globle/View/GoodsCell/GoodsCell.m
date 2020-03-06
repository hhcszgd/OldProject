//
//  GoodsCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GoodsCell.h"
#import "GuessLikeCellSub.h"
@interface GoodsCell()
@property (nonatomic, strong) GuessLikeCellSub *guessLike;
@end
@implementation GoodsCell



- (GuessLikeCellSub *)guessLike{
    if (_guessLike == nil) {
        _guessLike = [[GuessLikeCellSub alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:_guessLike];
    }
    return _guessLike;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.guessLike.backgroundColor = [UIColor whiteColor];
        
        
        
    }
    return self;
}







#pragma mark - 布局子控件
- (void)setImagestr:(NSString *)imagestr{
    self.imageView.image = [UIImage imageNamed:imagestr];
}
- (void)setPriceStr:(NSString *)priceStr{
    [_priceLabel configmentfont:[UIFont boldSystemFontOfSize:13] textColor:[UIColor redColor] backColor:[UIColor blackColor] textAligement:0 cornerRadius:0 text:priceStr];
}

- (void)setCountStr:(NSString *)countStr{
    
}
- (void)setTextStr:(NSString *)textStr{
    
}


- (void)setComposeModel:(HCellComposeModel *)composeModel{
    _composeModel = composeModel;
    self.guessLike.composeModel = composeModel;
}


- (void)setCollectionView:(UICollectionView *)collectionView{
    
}



@end
