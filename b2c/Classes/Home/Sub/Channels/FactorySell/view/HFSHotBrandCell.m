//
//  HFSHotBrandCell.m
//  b2c
//
//  Created by 0 on 16/4/6.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFSHotBrandCell.h"

@interface HFSHotBrandCell()
@property (nonatomic, strong) NSMutableArray *brandArray;

@end
@implementation HFSHotBrandCell

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



- (void)setFactoryModel:(HFactoryBaseModel *)factoryModel{
    NSInteger i = 0;
    for (HFactoryBaseModel *model in factoryModel.items) {
        UIImageView *imageView = self.brandArray[i++];
        if ([model.img isEqualToString:@"xxxxxxxx"]) {
            imageView.image  = [UIImage imageNamed:@"zhekouqu"];
        }else{
            NSURL *url = ImageUrlWithString(model.img);
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"me"]];
        }
        
    }
}


@end
