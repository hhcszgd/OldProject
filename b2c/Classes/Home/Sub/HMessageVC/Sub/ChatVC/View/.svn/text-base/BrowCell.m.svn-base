//
//  BrowCell.m
//  b2c
//
//  Created by wangyuanfei on 7/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "BrowCell.h"

@interface BrowCell ()

@property(nonatomic,weak)UIImageView * browImg ;

@end

@implementation BrowCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView * browImg = [[UIImageView alloc]init];
        self.browImg = browImg;
        browImg.contentMode =  UIViewContentModeCenter;
        [self.contentView addSubview:browImg];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.browImg.frame = self.bounds;
}


-(void)setBrowDict:(NSDictionary *)browDict{
    _browDict = browDict;
    self.browImg.image = [UIImage imageWithContentsOfFile:gotResourceInSubBundle(browDict[@"code"], @"gif", @"face_img")];
}
@end
