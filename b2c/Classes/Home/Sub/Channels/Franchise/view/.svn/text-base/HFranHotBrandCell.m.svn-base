//
//  HFranHotBrandCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFranHotBrandCell.h"

@interface HFranHotBrandCell()
@property (nonatomic, strong) NSMutableArray *brandArray;

@end
@implementation HFranHotBrandCell

- (NSMutableArray *)brandArray{
    if (_brandArray == nil) {
        _brandArray = [NSMutableArray array];
    }
    return _brandArray;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    CGFloat width = screenW/4.0;
    CGFloat height = self.contentView.bounds.size.height/2.0;
    for (NSInteger i = 0; i < 8; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4) * width, (i/4) * height, width, height)];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toBrandDetail:)];
        [imageView addGestureRecognizer:tap];
        [self.contentView addSubview:imageView];
        [self.brandArray addObject:imageView];
    }
}

- (void)toBrandDetail:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,tap.view)
}

- (void)setModel:(id)model{
    
    for (NSInteger i = 0; i < 8; i++) {
        UIImageView *imageView = self.brandArray[i];
        imageView.image = [UIImage imageNamed:@"zhekouqu"];
    }
    
    
}
@end
