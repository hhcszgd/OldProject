//
//  KDeleteCell.m
//  b2c
//
//  Created by wangyuanfei on 7/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "KDeleteCell.h"

@interface KDeleteCell ()
@property(nonatomic,weak)UIImageView * img ;
@end

@implementation KDeleteCell\

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor purpleColor];
        UIImageView * deleteImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_icon_jian"]];
        [self.contentView addSubview:deleteImg];
        self.img = deleteImg;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.img.bounds = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height/2.7*SCALE);
    self.img.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);

}
@end
